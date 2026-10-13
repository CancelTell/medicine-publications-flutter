import 'package:flutter/material.dart';
import 'package:pubmed_catalog/common/theme/image_sources.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';
import '../../domain/article_model.dart';
import 'article_type_format.dart';

extension ArticleFormat on ArticleModel {
  String authorsShort(AppLocalizations l10n) {
    if (authors.isEmpty) return '';
    if (authors.length == 1) return authors.first;
    return l10n.articleAuthorsShort(authors.first);
  }

  String get authorsFull => authors.join(', ');

  String get year => publishedAt.year.toString();

  String get displayPmid => pmid.toString();

  String get cover => ImageSources.articlePlaceholder;

  Color get accent => type.color;
}