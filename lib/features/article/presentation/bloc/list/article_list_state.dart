import 'package:pubmed_catalog/common/network/load_exception.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';

sealed class ArticleListState {
  const ArticleListState({required this.query});

  final String query;
}

final class ArticleListLoading extends ArticleListState {
  const ArticleListLoading({super.query = ''});
}

final class ArticleListLoaded extends ArticleListState {
  const ArticleListLoaded({
    required super.query,
    required this.articles,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<ArticleModel> articles;
  final bool hasMore;
  final bool isLoadingMore;
  final LoadException? loadMoreError;
}

final class ArticleListNotFound extends ArticleListState {
  const ArticleListNotFound({required super.query});
}

final class ArticleListFailure extends ArticleListState {
  const ArticleListFailure({
    required super.query,
    required this.error,
  });

  final LoadException error;
}