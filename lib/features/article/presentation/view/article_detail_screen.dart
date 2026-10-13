import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/common/widgets/app_scaffold.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/domain/i_article_repository.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/detail/article_detail_state.dart';
import 'package:pubmed_catalog/features/article/presentation/utils/article_format.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/article_card.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/article_cover.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/article_facts.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/section.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/type_chip.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';

import '../bloc/detail/article_detail_bloc.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.pmid});

  final int pmid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ArticleDetailBloc(context.read<IArticleRepository>())
        ..add(ArticleDetailOpened(pmid)),
      child: AppScaffold(
        body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
          builder: (context, state) => switch (state) {
            ArticleDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ArticleDetailNotFound(:final pmid) => Center(
              child: Text(
                AppLocalizations.of(context).detailNotFound(pmid.toString()),
              ),
            ),
            ArticleDetailLoaded(:final article, :final related) =>
                _DetailContent(article: article, related: related),
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.article, required this.related});

  final ArticleModel article;
  final List<ArticleModel> related;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              ArticleCover(article: article, size: 96),
              TypeChip(type: article.type),
              SelectableText(
                article.title,
                style: theme.textTheme.headlineSmall,
              ),
              ArticleFacts(article: article),
              Text(article.description, style: theme.textTheme.bodyLarge),
              Section(title: l10n.sectionAuthors),
              Text(article.authorsFull, style: theme.textTheme.bodyLarge),
              Section(title: l10n.sectionRelated),
              if (related.isEmpty)
                Text(
                  l10n.relatedEmpty,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              for (final item in related) ArticleCard(article: item),
            ],
          ),
        ),
      ),
    );
  }
}