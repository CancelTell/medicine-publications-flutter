

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/i_article_repository.dart';
import 'article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this._repository) : super(const ArticleListLoading());
  final IArticleRepository _repository;
  String _latestQuery = '';
  Future<void> load() async {
    final articles = await _repository.getArticles();
    if (isClosed) return;
    emit(ArticleListLoaded(query: '', articles: articles));
  }
  Future<void> search(String query) async {
    _latestQuery = query;
    final articles = await _repository.searchArticles(query);
    if (isClosed) return;
    if (query != _latestQuery) return;
    emit(
      articles.isEmpty
          ? ArticleListNotFound(query: query)
          : ArticleListLoaded(query: query, articles: articles),
    );
  }
}