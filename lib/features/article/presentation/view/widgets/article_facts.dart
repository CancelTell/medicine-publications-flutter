import 'package:flutter/material.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/presentation/utils/article_format.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';

class ArticleFacts extends StatelessWidget {
  const ArticleFacts({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Wrap(
      spacing: 24,
      runSpacing: 4,
      children: [
        Text(l10n.articlePublished(article.publishedAt), style: style),
        Text(l10n.articlePmid(article.displayPmid), style: style),
      ],
    );
  }
}