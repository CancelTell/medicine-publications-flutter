import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/domain/i_article_repository.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/detail/article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(this._repository) : super(const ArticleDetailLoading()) {
    on<ArticleDetailOpened>(_onOpened);
  }

  final IArticleRepository _repository;

  Future<void> _onOpened(
    ArticleDetailOpened event,
    Emitter<ArticleDetailState> emit,
  ) async {
    final article = await _repository.getArticle(event.pmid);
    if (article == null) {
      emit(ArticleDetailNotFound(event.pmid));
      return;
    }
    final related = <ArticleModel>[];
    for (final id in article.relatedIds) {
      final item = await _repository.getArticle(id);
      if (item != null) related.add(item);
    }
    emit(ArticleDetailLoaded(article, related: related));
  }
}
