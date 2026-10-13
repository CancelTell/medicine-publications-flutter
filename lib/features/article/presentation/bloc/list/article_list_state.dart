import '../../../domain/article_model.dart';

sealed class ArticleListState {
  const ArticleListState({required this.query});
  final String query;
}
final class ArticleListLoading extends ArticleListState {
  const ArticleListLoading({super.query = ''});
}
final class ArticleListLoaded extends ArticleListState {
  const ArticleListLoaded({required super.query, required this.articles});

  final List<ArticleModel> articles;
}
final class ArticleListNotFound extends ArticleListState {
  const ArticleListNotFound({required super.query});
}