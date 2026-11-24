import 'package:pubmed_catalog/common/network/load_exception.dart';
import 'package:pubmed_catalog/features/article/data/dto/article_links_dto.dart';

extension ArticleLinksDtoMapper on ArticleLinksDto {
  List<int> relatedIds({required int currentPmid, int limit = 3}) {
    final ids = <int>{};

    for (final set in linkSets) {
      for (final database in set.databases) {
        if (database.linkName != 'pubmed_pubmed') continue;

        for (final value in database.ids) {
          final id = int.tryParse(value);

          if (id == null) {
            throw const BadResponseException();
          }

          if (id != currentPmid) {
            ids.add(id);
          }
        }
      }
    }

    return ids.take(limit).toList();
  }
}
