// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_links_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleLinksDto _$ArticleLinksDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ArticleLinksDto', json, ($checkedConvert) {
      final val = ArticleLinksDto(
        linkSets: $checkedConvert(
          'linksets',
          (v) => (v as List<dynamic>)
              .map((e) => ArticleLinkSetDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'linkSets': 'linksets'});

ArticleLinkSetDto _$ArticleLinkSetDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ArticleLinkSetDto', json, ($checkedConvert) {
      final val = ArticleLinkSetDto(
        databases: $checkedConvert(
          'linksetdbs',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) => ArticleLinkDatabaseDto.fromJson(
                      e as Map<String, dynamic>,
                    ),
                  )
                  .toList() ??
              [],
        ),
      );
      return val;
    }, fieldKeyMap: const {'databases': 'linksetdbs'});

ArticleLinkDatabaseDto _$ArticleLinkDatabaseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ArticleLinkDatabaseDto', json, ($checkedConvert) {
  final val = ArticleLinkDatabaseDto(
    linkName: $checkedConvert('linkname', (v) => v as String),
    ids: $checkedConvert(
      'links',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
  );
  return val;
}, fieldKeyMap: const {'linkName': 'linkname', 'ids': 'links'});
