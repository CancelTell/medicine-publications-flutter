import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/common/network/load_exception.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/domain/i_article_repository.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/list/article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this._repository)
      : super(const ArticleListLoading());

  final IArticleRepository _repository;

  static const Duration _searchDelay = Duration(milliseconds: 400);

  Timer? _searchTimer;
  int _requestId = 0;

  Future<void> load() => _start('');

  Future<void> retry() => _start(state.query);

  void search(String query) {
    if (isClosed) return;

    _searchTimer?.cancel();

    final normalized = query.trim();
    final requestId = ++_requestId;

    emit(ArticleListLoading(query: normalized));

    _searchTimer = Timer(_searchDelay, () {
      unawaited(_fetch(normalized, requestId));
    });
  }

  Future<void> _start(String query) async {
    if (isClosed) return;

    _searchTimer?.cancel();

    final requestId = ++_requestId;

    emit(ArticleListLoading(query: query));

    await _fetch(query, requestId);
  }

  Future<void> _fetch(String query, int requestId) async {
    try {
      final articles = query.isEmpty
          ? await _repository.getArticles()
          : await _repository.searchArticles(query);

      if (isClosed || requestId != _requestId) return;

      if (articles.isEmpty && query.isNotEmpty) {
        emit(ArticleListNotFound(query: query));
        return;
      }

      emit(
        ArticleListLoaded(
          query: query,
          articles: List<ArticleModel>.unmodifiable(articles),
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || requestId != _requestId) return;

      emit(
        ArticleListFailure(
          query: query,
          error: error,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    _requestId++;
    return super.close();
  }
}