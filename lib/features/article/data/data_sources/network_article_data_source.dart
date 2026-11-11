import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pubmed_catalog/common/network/load_exception.dart';
import 'package:pubmed_catalog/features/article/data/api/article_api.dart';
import 'package:pubmed_catalog/features/article/data/data_sources/i_article_data_source.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_abstract_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_links_dto.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_search_dto.dart';
import 'package:xml/xml.dart';

final class NetworkArticleDataSource implements IArticleDataSource {
  const NetworkArticleDataSource(this._api);

  final ArticleApi _api;

  @override
  Future<ArticleSearchResponseDto> searchArticles({
    required String query,
    int offset = 0,
    int limit = 20,
  }) => _guard(
    () => _api.searchArticles(query: query, offset: offset, limit: limit),
  );

  @override
  Future<List<ArticleDto>> getArticles(List<String> ids) =>
      _guard(() => _api.getArticles(ids));

  @override
  Future<ArticleLinksDto> getRelatedArticles(String pmid) =>
      _guard(() => _api.getRelatedArticles(pmid));

  @override
  Future<ArticleAbstractDto> getAbstract(String pmid) =>
      _guard(() => _api.getAbstract(pmid));

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on CheckedFromJsonException {
      throw const BadResponseException();
    } on XmlParserException {
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutLoadException(),

    DioExceptionType.badResponse when error.response?.statusCode == 404 =>
      const NotFoundException(),

    DioExceptionType.badResponse => ServerException(error.response?.statusCode),

    DioExceptionType.unknown when error.error is FormatException =>
      const BadResponseException(),

    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate ||
    DioExceptionType.cancel ||
    DioExceptionType.unknown => const NoConnectionException(),
  };
}
