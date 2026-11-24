import 'package:pubmed_catalog/common/network/load_exception.dart';
import 'package:pubmed_catalog/features/article/data/data_sources/i_article_data_source.dart';
import 'package:pubmed_catalog/features/article/data/mappers/article_links_mapper.dart';
import 'package:pubmed_catalog/features/article/data/mappers/article_mapper.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/domain/i_article_repository.dart';

final class ArticleRepository implements IArticleRepository {
  const ArticleRepository(this._dataSource);

  final IArticleDataSource _dataSource;

  static const String _defaultQuery = 'medicine';
  static const int _searchLimit = 20;

  @override
  Future<List<ArticleModel>> getArticles({int offset = 0, int limit = 20}) =>
      _search(_defaultQuery, offset: offset, limit: limit);

  @override
  Future<List<ArticleModel>> searchArticles(String query) {
    final normalized = query.trim();

    if (normalized.isEmpty) {
      return getArticles();
    }

    return _search(normalized, offset: 0, limit: _searchLimit);
  }

  Future<List<ArticleModel>> _search(
    String query, {
    required int offset,
    required int limit,
  }) async {
    final response = await _dataSource.searchArticles(
      query: query,
      offset: offset,
      limit: limit,
    );

    final ids = response.result.ids;

    if (ids.isEmpty) {
      return [];
    }

    final articles = await _dataSource.getArticles(ids);

    return [for (final article in articles) article.toModel()];
  }

  @override
  Future<List<ArticleModel>> getRelated(List<int> ids) async {
    if (ids.isEmpty) {
      return [];
    }

    final articles = await _dataSource.getArticles([
      for (final id in ids) id.toString(),
    ]);

    return [for (final article in articles) article.toModel()];
  }

  @override
  Future<ArticleModel?> getArticle(int pmid) async {
    if (pmid <= 0) return null;

    final id = pmid.toString();

    try {
      final abstract = await _dataSource.getAbstract(id);

      if (abstract.pmid == null) {
        return null;
      }

      if (abstract.pmid != id) {
        throw const BadResponseException();
      }

      final articles = await _dataSource.getArticles([id]);

      if (articles.length != 1 || articles.single.pmid != id) {
        throw const BadResponseException();
      }

      var relatedIds = const <int>[];

      try {
        final links = await _dataSource.getRelatedArticles(id);
        relatedIds = links.relatedIds(currentPmid: pmid);
      } on LoadException {
        relatedIds = const [];
      }

      return articles.single.toModel(
        description: abstract.text,
        relatedIds: relatedIds,
      );
    } on NotFoundException {
      return null;
    }
  }
}
