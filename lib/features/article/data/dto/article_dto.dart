import 'package:json_annotation/json_annotation.dart';

part 'article_dto.g.dart';

@JsonSerializable()
class ArticleDto {
  const ArticleDto({
    required this.pmid,
    required this.title,
    required this.authors,
    required this.pubDate,
    required this.sortPubDate,
    required this.pubTypes,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);

  @JsonKey(name: 'uid')
  final String pmid;

  final String title;

  final List<ArticleAuthorDto> authors;

  @JsonKey(name: 'pubdate')
  final String pubDate;

  @JsonKey(name: 'sortpubdate')
  final String sortPubDate;

  @JsonKey(name: 'pubtype')
  final List<String> pubTypes;
}

@JsonSerializable()
class ArticleAuthorDto {
  const ArticleAuthorDto({required this.name});

  factory ArticleAuthorDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleAuthorDtoFromJson(json);

  final String name;
}
