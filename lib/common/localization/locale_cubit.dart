import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({Locale initial = russian}) : super(initial);

  static const Locale russian = Locale('ru');
  static const Locale english = Locale('en');

  void toggle() {
    emit(state.languageCode == russian.languageCode ? english : russian);
  }
}