// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSearchResponseDto _$ArticleSearchResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ArticleSearchResponseDto', json, ($checkedConvert) {
  final val = ArticleSearchResponseDto(
    result: $checkedConvert(
      'esearchresult',
      (v) => ArticleSearchResultDto.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'result': 'esearchresult'});

ArticleSearchResultDto _$ArticleSearchResultDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ArticleSearchResultDto', json, ($checkedConvert) {
  final val = ArticleSearchResultDto(
    count: $checkedConvert('count', (v) => v as String),
    ids: $checkedConvert(
      'idlist',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
  );
  return val;
}, fieldKeyMap: const {'ids': 'idlist'});
