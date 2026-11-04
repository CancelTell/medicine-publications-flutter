import 'package:pubmed_catalog/features/article/data/dto/article_abstract_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_links_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_search_dto.dart';

abstract interface class IArticleDataSource {
  Future<ArticleSearchResponseDto> searchArticles({
    required String query,
    int offset = 0,
    int limit = 20,
  });

  Future<List<ArticleDto>> getArticles(List<String> ids);

  Future<ArticleLinksDto> getRelatedArticles(String pmid);

  Future<ArticleAbstractDto> getAbstract(String pmid);
}