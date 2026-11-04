import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/common/network/load_exception.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/domain/i_article_repository.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/detail/article_detail_state.dart';

class ArticleDetailBloc
    extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(this._repository)
      : super(const ArticleDetailLoading()) {
    on<ArticleDetailOpened>(_onLoadRequested);
    on<ArticleDetailRetried>(_onLoadRequested);
  }

  final IArticleRepository _repository;

  int _requestId = 0;

  Future<void> _onLoadRequested(
      ArticleDetailEvent event,
      Emitter<ArticleDetailState> emit,
      ) async {
    final requestId = ++_requestId;

    emit(const ArticleDetailLoading());

    try {
      final article = await _repository.getArticle(event.pmid);

      if (emit.isDone || requestId != _requestId) return;

      if (article == null) {
        emit(ArticleDetailNotFound(event.pmid));
        return;
      }

      final found = await Future.wait(
        article.relatedIds.map(_repository.getArticle),
      );

      if (emit.isDone || requestId != _requestId) return;

      final related = found.whereType<ArticleModel>();

      emit(
        ArticleDetailLoaded(
          article,
          related: List<ArticleModel>.unmodifiable(related),
        ),
      );
    } on LoadException catch (error) {
      if (emit.isDone || requestId != _requestId) return;

      emit(ArticleDetailFailure(event.pmid, error));
    }
  }
}