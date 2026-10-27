import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/features/article/domain/i_article_repository.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/list/article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this._repository) : super(const ArticleListLoading());
  final IArticleRepository _repository;
  String _latestQuery = '';
  Future<void> load() => search('');
  Future<void> search(String query) async {
    _latestQuery = query;
    final isEmptyQuery = query.trim().isEmpty;
    final articles = isEmptyQuery
        ? await _repository.getArticles()
        : await _repository.searchArticles(query);
    if (isClosed || query != _latestQuery) return;
    emit(
      articles.isEmpty && !isEmptyQuery
          ? ArticleListNotFound(query: query)
          : ArticleListLoaded(query: query, articles: articles),
    );
  }
}