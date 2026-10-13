import 'package:flutter/material.dart';
import 'package:pubmed_catalog/common/theme/app_colors.dart';
import 'package:pubmed_catalog/features/article/domain/article_type.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';

extension ArticleTypeFormat on ArticleType {
  Color get color => switch (this) {
    ArticleType.research => AppColors.typeResearch,
    ArticleType.review => AppColors.typeReview,
    ArticleType.randTrial => AppColors.typeRandTrial,
    ArticleType.validStudy => AppColors.typeValidStudy,
  };
  
  IconData get icon => switch (this) {
    ArticleType.research => Icons.science_outlined,
    ArticleType.review => Icons.library_books_outlined,
    ArticleType.randTrial => Icons.groups_outlined,
    ArticleType.validStudy => Icons.verified_outlined,
  };

  String label(AppLocalizations l10n) => switch (this) {
    ArticleType.research => l10n.typeResearch,
    ArticleType.review => l10n.typeReview,
    ArticleType.randTrial => l10n.typeRandTrial,
    ArticleType.validStudy => l10n.typeValidStudy,
  };
}