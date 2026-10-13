import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubmed_catalog/app.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const App());
}