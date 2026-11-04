import 'package:flutter/material.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';

class NothingFound extends StatelessWidget {
  const NothingFound({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            Text(
              l10n.searchNothingFound(query),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            Text(
              l10n.searchNothingFoundHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
