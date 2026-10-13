import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/common/widgets/app_scaffold.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/list/article_list_cubit.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/list/article_list_state.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/article_card.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/nothing_found.dart';
import 'package:pubmed_catalog/features/article/presentation/view/widgets/search_field.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});
  static const double _maxContentWidth = 840;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArticleListCubit>();
    return AppScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final side = math.max(
            16.0,
            (constraints.maxWidth - _maxContentWidth) / 2,
          );
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(side, 16, side, 8),
                child: SearchField(
                  initialQuery: cubit.state.query,
                  onChanged: cubit.search,
                ),
              ),
              Expanded(
                child: BlocBuilder<ArticleListCubit, ArticleListState>(
                  builder: (context, state) => switch (state) {
                    ArticleListLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    ArticleListNotFound(:final query) => NothingFound(
                      query: query,
                    ),
                    ArticleListLoaded(:final articles) => _ArticleList(
                      articles: articles,
                      side: side,
                    ),
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ArticleList extends StatelessWidget {
  const _ArticleList({required this.articles, required this.side});

  final List<ArticleModel> articles;
  final double side;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: side),
          child: Text(
            AppLocalizations.of(context).listFound(articles.length),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(side, 12, side, 16),
            itemCount: articles.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                ArticleCard(article: articles[index]),
          ),
        ),
      ],
    );
  }
}
