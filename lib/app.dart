import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/common/navigation/app_router.dart';
import 'package:pubmed_catalog/common/theme/app_theme.dart';
import 'package:pubmed_catalog/features/article/data/article_repository.dart';
import 'package:pubmed_catalog/features/article/domain/i_article_repository.dart';
import 'package:pubmed_catalog/features/article/presentation/bloc/list/article_list_cubit.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IArticleRepository>(
      create: (_) => const ArticleRepository(),

      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            ArticleListCubit(context.read<IArticleRepository>())..load(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}