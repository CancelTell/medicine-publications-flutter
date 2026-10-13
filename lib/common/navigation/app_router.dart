import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubmed_catalog/common/widgets/app_scaffold.dart';
import 'package:pubmed_catalog/features/article/presentation/view/article_list_screen.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';
abstract final class AppRoutes {
  static const String list = '/';
  static String detail(int pmid) => '/article/$pmid';
}
abstract final class AppRouter {
  static final GoRouter router = _create();

  static GoRouter _create() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return GoRouter(
      initialLocation: AppRoutes.list,
      routes: [
        GoRoute(
          path: AppRoutes.list,
          builder: (context, state) => const ArticleListScreen(),
          routes: [
          ],
        ),
      ],
      errorBuilder: (context, state) => const _NotFoundScreen(),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(child: Text(AppLocalizations.of(context).pageNotFound)),
    );
  }
}