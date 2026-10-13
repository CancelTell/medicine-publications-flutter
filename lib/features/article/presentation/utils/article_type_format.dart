
import 'dart:ui';

import 'package:pubmed_catalog/l10n/app_localizations.dart';

import '../../../../common/theme/app_colors.dart';
import '../../domain/article_type.dart';

extension ArticleTypeFormat on ArticleType {
  Color get color => switch (this) {
    ArticleType.research => AppColors.typeResearch,
    ArticleType.randTrial => AppColors.typeRandTrial,
    ArticleType.review => AppColors.typeReview,
    ArticleType.validStudy => AppColors.typeValidStudy,
  };

  String label(AppLocalizations l10n) => switch (this) {
    ArticleType.research => l10n.typeResearch,
    ArticleType.validStudy => l10n.typeValidStudy,
    ArticleType.review => l10n.typeReview,
    ArticleType.randTrial => l10n.typeRandTrial,
  };
}

// enum ArticleType { research, review, randTrial, validStudy}