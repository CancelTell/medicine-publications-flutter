import 'package:dio/dio.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_abstract_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_links_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_search_dto.dart';

final class ArticleApi {
  const ArticleApi(this._dio);

  final Dio _dio;

  Future<ArticleSearchResponseDto> searchArticles({
    required String query,
    int offset = 0,
    int limit = 20,
  }) async {
    final json = await _getJson(
      'esearch.fcgi',
      queryParameters: {
        'db': 'pubmed',
        'retmode': 'json',
        'term': query,
        'retstart': offset,
        'retmax': limit,
      },
    );

    return ArticleSearchResponseDto.fromJson(json);
  }

  Future<List<ArticleDto>> getArticles(List<String> ids) async {
    if (ids.isEmpty) return [];

    final json = await _getJson(
      'esummary.fcgi',
      queryParameters: {'db': 'pubmed', 'retmode': 'json', 'id': ids.join(',')},
    );

    final result = json['result'];

    if (result is! Map<String, dynamic>) {
      throw const FormatException('Нет объекта result');
    }

    final uids = result['uids'];

    if (uids is! List<dynamic>) {
      throw const FormatException('Нет списка uids');
    }

    final articles = <ArticleDto>[];

    for (final uid in uids) {
      if (uid is! String) {
        throw const FormatException('Некорректный PMID');
      }

      final article = result[uid];

      if (article is! Map<String, dynamic>) {
        throw const FormatException('Некорректный объект статьи');
      }

      articles.add(ArticleDto.fromJson(article));
    }

    return articles;
  }

  Future<ArticleLinksDto> getRelatedArticles(String pmid) async {
    final json = await _getJson(
      'elink.fcgi',
      queryParameters: {
        'dbfrom': 'pubmed',
        'db': 'pubmed',
        'retmode': 'json',
        'id': pmid,
        'linkname': 'pubmed_pubmed',
      },
    );

    return ArticleLinksDto.fromJson(json);
  }

  Future<ArticleAbstractDto> getAbstract(String pmid) async {
    final response = await _dio.get<String>(
      'efetch.fcgi',
      queryParameters: {'db': 'pubmed', 'retmode': 'xml', 'id': pmid},
      options: Options(responseType: ResponseType.plain),
    );

    final source = response.data;

    if (source == null || source.trim().isEmpty) {
      throw const FormatException('Пустой ответ EFetch');
    }

    return ArticleAbstractDto.fromXml(source);
  }

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );

    return response.data ?? (throw const FormatException('Пустой ответ'));
  }
}
