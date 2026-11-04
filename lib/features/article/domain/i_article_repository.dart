import 'package:pubmed_catalog/features/article/domain/article_model.dart';

abstract interface class IArticleRepository {
  Future<List<ArticleModel>> getArticles({
    int offset = 0,
    int limit = 20,
  });

  Future<ArticleModel?> getArticle(int pmid);

  Future<List<ArticleModel>> searchArticles(String query);
}