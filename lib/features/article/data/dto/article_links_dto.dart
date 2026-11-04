import 'package:json_annotation/json_annotation.dart';

part 'article_links_dto.g.dart';

@JsonSerializable()
class ArticleLinksDto {
  const ArticleLinksDto({required this.linkSets});

  factory ArticleLinksDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleLinksDtoFromJson(json);

  @JsonKey(name: 'linksets')
  final List<ArticleLinkSetDto> linkSets;
}

@JsonSerializable()
class ArticleLinkSetDto {
  const ArticleLinkSetDto({required this.databases});

  factory ArticleLinkSetDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleLinkSetDtoFromJson(json);

  @JsonKey(name: 'linksetdbs', defaultValue: <ArticleLinkDatabaseDto>[])
  final List<ArticleLinkDatabaseDto> databases;
}

@JsonSerializable()
class ArticleLinkDatabaseDto {
  const ArticleLinkDatabaseDto({
    required this.linkName,
    required this.ids,
  });

  factory ArticleLinkDatabaseDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleLinkDatabaseDtoFromJson(json);

  @JsonKey(name: 'linkname')
  final String linkName;

  @JsonKey(name: 'links')
  final List<String> ids;
}