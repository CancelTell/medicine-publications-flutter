import 'package:flutter/material.dart';

import '../../../../../common/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/article_type.dart';
import '../../utils/article_type_format.dart';

class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.type});
  final ArticleType type;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: type.color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text(
          type.label(AppLocalizations.of(context)),
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: AppColors.onType),
        ),
      ),
    );
  }
}
