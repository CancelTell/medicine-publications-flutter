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
  static const int _pageSize = 20;

  @override
  Future<List<ArticleModel>> getArticles() =>
      _search(_defaultQuery);

  @override
  Future<List<ArticleModel>> searchArticles(String query) {
    final normalized = query.trim();

    if (normalized.isEmpty) {
      return getArticles();
    }

    return _search(normalized);
  }

  Future<List<ArticleModel>> _search(String query) async {
    final response = await _dataSource.searchArticles(
      query: query,
      limit: _pageSize,
    );

    final ids = response.result.ids;

    if (ids.isEmpty) {
      return [];
    }

    final articles = await _dataSource.getArticles(ids);

    return [
      for (final article in articles) article.toModel(),
    ];
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

      final links = await _dataSource.getRelatedArticles(id);

      return articles.single.toModel(
        description: abstract.text,
        relatedIds: links.relatedIds(currentPmid: pmid),
      );
    } on NotFoundException {
      return null;
    }
  }
}