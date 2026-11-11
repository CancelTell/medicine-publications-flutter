import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/common/widgets/app_scaffold.dart';
import 'package:pubmed_catalog/common/widgets/load_error_view.dart';
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
                    ArticleListFailure(:final error) => Center(
                      child: LoadErrorView(error: error, onRetry: cubit.retry),
                    ),
                    ArticleListLoaded() => _ArticleList(
                      key: ValueKey(state.query),
                      state: state,
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

class _ArticleList extends StatefulWidget {
  const _ArticleList({super.key, required this.state, required this.side});

  final ArticleListLoaded state;
  final double side;

  @override
  State<_ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<_ArticleList> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()..addListener(_onScroll);
    _scheduleScrollCheck();
  }

  @override
  void didUpdateWidget(covariant _ArticleList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleScrollCheck();
  }

  void _scheduleScrollCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _onScroll();
    });
  }

  void _onScroll() {
    if (!_controller.hasClients) return;

    if (_controller.position.extentAfter < 240) {
      context.read<ArticleListCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final side = widget.side;
    final theme = Theme.of(context);

    final showFooter = state.isLoadingMore || state.loadMoreError != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: side),
          child: Text(
            AppLocalizations.of(context).listFound(state.articles.length),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            key: PageStorageKey<String>('article-list-${state.query}'),
            controller: _controller,
            padding: EdgeInsets.fromLTRB(side, 12, side, 16),
            itemCount: state.articles.length + (showFooter ? 1 : 0),
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index < state.articles.length) {
                return ArticleCard(article: state.articles[index]);
              }

              return _PaginationFooter(state: state);
            },
          ),
        ),
      ],
    );
  }
}

class _PaginationFooter extends StatelessWidget {
  const _PaginationFooter({required this.state});

  final ArticleListLoaded state;

  @override
  Widget build(BuildContext context) {
    final error = state.loadMoreError;

    return Center(
      child: error == null
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          : LoadErrorView(
              error: error,
              onRetry: () {
                context.read<ArticleListCubit>().loadMore(retry: true);
              },
            ),
    );
  }
}
