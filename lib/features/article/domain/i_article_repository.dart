abstract interface class IArticleRepository {
  Future<List<ArticleModel>> getArticles();
  Future<ArticleModel?> getArticle(int pmid);
  Future<List<ArticleModel>> searchArticles (String query);
}