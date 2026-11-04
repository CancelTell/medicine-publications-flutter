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

  static const int _pageSize = 20;
  static const Duration _searchDelay = Duration(milliseconds: 400);

  Timer? _searchTimer;

  int _requestId = 0;
  int _nextOffset = 0;

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
          ? await _repository.getArticles(
        offset: 0,
        limit: _pageSize,
      )
          : await _repository.searchArticles(query);

      if (!_isCurrent(requestId)) return;

      _nextOffset = articles.length;

      if (articles.isEmpty && query.isNotEmpty) {
        emit(ArticleListNotFound(query: query));
        return;
      }

      emit(
        ArticleListLoaded(
          query: query,
          articles: _withoutDuplicates(articles),
          hasMore: query.isEmpty && articles.length == _pageSize,
        ),
      );
    } on LoadException catch (error) {
      if (!_isCurrent(requestId)) return;

      emit(
        ArticleListFailure(
          query: query,
          error: error,
        ),
      );
    }
  }

  Future<void> loadMore({bool retry = false}) async {
    if (isClosed) return;

    final current = state;

    if (current is! ArticleListLoaded ||
        current.query.isNotEmpty ||
        !current.hasMore ||
        current.isLoadingMore ||
        (current.loadMoreError != null && !retry)) {
      return;
    }

    final requestId = _requestId;
    final offset = _nextOffset;

    emit(
      ArticleListLoaded(
        query: current.query,
        articles: current.articles,
        hasMore: current.hasMore,
        isLoadingMore: true,
      ),
    );

    try {
      final next = await _repository.getArticles(
        offset: offset,
        limit: _pageSize,
      );

      if (!_isCurrent(requestId)) return;

      _nextOffset = offset + next.length;

      emit(
        ArticleListLoaded(
          query: current.query,
          articles: _withoutDuplicates([
            ...current.articles,
            ...next,
          ]),
          hasMore: next.length == _pageSize,
        ),
      );
    } on LoadException catch (error) {
      if (!_isCurrent(requestId)) return;

      emit(
        ArticleListLoaded(
          query: current.query,
          articles: current.articles,
          hasMore: current.hasMore,
          loadMoreError: error,
        ),
      );
    }
  }

  bool _isCurrent(int requestId) =>
      !isClosed && requestId == _requestId;

  List<ArticleModel> _withoutDuplicates(
      Iterable<ArticleModel> articles,
      ) {
    final seen = <int>{};

    return List<ArticleModel>.unmodifiable(
      articles.where((article) => seen.add(article.pmid)),
    );
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    _requestId++;
    return super.close();
  }
}