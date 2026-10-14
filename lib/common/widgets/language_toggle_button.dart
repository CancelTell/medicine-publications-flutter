import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubmed_catalog/common/localization/locale_cubit.dart';
import 'package:pubmed_catalog/l10n/app_localizations.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Tooltip(
      message: l10n.actionToggleLanguage,
      child: TextButton.icon(
        onPressed: () => context.read<LocaleCubit>().toggle(),
        icon: const Icon(Icons.translate),
        label: Text(l10n.languageCode),
      ),
    );
  }
}
