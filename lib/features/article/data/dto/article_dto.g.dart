// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ArticleDto',
  json,
  ($checkedConvert) {
    final val = ArticleDto(
      pmid: $checkedConvert('uid', (v) => v as String),
      title: $checkedConvert('title', (v) => v as String),
      authors: $checkedConvert(
        'authors',
        (v) => (v as List<dynamic>)
            .map((e) => ArticleAuthorDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      pubDate: $checkedConvert('pubdate', (v) => v as String),
      sortPubDate: $checkedConvert('sortpubdate', (v) => v as String),
      pubTypes: $checkedConvert(
        'pubtype',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'pmid': 'uid',
    'pubDate': 'pubdate',
    'sortPubDate': 'sortpubdate',
    'pubTypes': 'pubtype',
  },
);

ArticleAuthorDto _$ArticleAuthorDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ArticleAuthorDto', json, ($checkedConvert) {
      final val = ArticleAuthorDto(
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });
