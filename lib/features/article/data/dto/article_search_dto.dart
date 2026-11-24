import 'package:json_annotation/json_annotation.dart';

part 'article_search_dto.g.dart';

@JsonSerializable()
class ArticleSearchResponseDto {
  const ArticleSearchResponseDto({required this.result});

  factory ArticleSearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleSearchResponseDtoFromJson(json);

  @JsonKey(name: 'esearchresult')
  final ArticleSearchResultDto result;
}

@JsonSerializable()
class ArticleSearchResultDto {
  const ArticleSearchResultDto({required this.count, required this.ids});

  factory ArticleSearchResultDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleSearchResultDtoFromJson(json);

  final String count;

  @JsonKey(name: 'idlist')
  final List<String> ids;
}
