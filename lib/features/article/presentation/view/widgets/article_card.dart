import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubmed_catalog/common/navigation/app_router.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/presentation/utils/article_format.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/article_cover.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/card_surface.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/type_chip.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final secondary = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return CardSurface(
      onTap: () => context.push(AppRoutes.detail(article.pmid)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArticleCover(article: article, size: 64),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                TypeChip(type: article.type),
                Text(
                  article.title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(article.authorsShort(l10n), style: secondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
