import 'article_type.dart';

final class ArticleModel {
  const ArticleModel({
    required this.pmid,
    required this.title,
    required this.authors,
    required this.description,
    required this.type,
    required this.publishedAt,
    required this.relatedIds,
  });

  final int pmid;
  final List<String> authors;
  final String title;
  final String description;
  final ArticleType type;
  final DateTime publishedAt;
  final List<int> relatedIds;
}
