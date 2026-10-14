import 'package:pubmed_catalog/features/article/data/mock_articles.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/domain/i_article_repository.dart';

final class ArticleRepository implements IArticleRepository {
  const ArticleRepository();

  @override
  Future<List<ArticleModel>> getArticles() async => mockArticles;

  @override
  Future<ArticleModel?> getArticle(int pmid) async {
    for (final article in mockArticles) {
      if (article.pmid == pmid) return article;
    }
    return null;
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return mockArticles;
    return [
      for (final article in mockArticles)
        if (_matches(article, needle)) article,
    ];
  }

  static bool _matches(ArticleModel article, String needle) =>
      article.title.toLowerCase().contains(needle) ||
      article.description.toLowerCase().contains(needle) ||
      article.authors.any((author) => author.toLowerCase().contains(needle));
}
