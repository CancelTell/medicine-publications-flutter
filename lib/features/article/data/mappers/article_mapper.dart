import 'package:pubmed_catalog/common/network/load_exception.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_dto.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/domain/article_type.dart';

extension ArticleDtoMapper on ArticleDto {
  ArticleModel toModel({
    String description = '',
    List<int> relatedIds = const [],
  }) {
    final id = int.tryParse(pmid);
    final date = DateTime.tryParse(sortPubDate.replaceAll('/', '-'));

    if (id == null || date == null) {
      throw const BadResponseException();
    }

    return ArticleModel(
      pmid: id,
      title: title,
      authors: [for (final author in authors) author.name],
      description: description,
      type: _articleType(pubTypes),
      publishedAt: date,
      relatedIds: List<int>.unmodifiable(relatedIds),
    );
  }
}

ArticleType _articleType(List<String> types) {
  if (types.contains('Randomized Controlled Trial')) {
    return ArticleType.randTrial;
  }

  if (types.contains('Validation Study')) {
    return ArticleType.validStudy;
  }

  if (types.contains('Review') ||
      types.contains('Systematic Review') ||
      types.contains('Meta-Analysis')) {
    return ArticleType.review;
  }

  return ArticleType.research;
}
