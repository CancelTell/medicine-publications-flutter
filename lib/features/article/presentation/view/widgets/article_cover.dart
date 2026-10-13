import 'package:flutter/material.dart';
import 'package:pubmed_catalog/common/theme/app_colors.dart';
import 'package:pubmed_catalog/features/article/domain/article_model.dart';
import 'package:pubmed_catalog/features/article/presentation/utils/article_format.dart';
import 'package:pubmed_catalog/features/article/presentation/utils/article_type_format.dart';

class ArticleCover extends StatelessWidget {
  const ArticleCover({super.key, required this.article, required this.size});

  final ArticleModel article;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: article.accent,
        borderRadius: BorderRadius.circular(size / 5),
      ),
      child: Icon(article.type.icon, size: size * 0.55, color: AppColors.onType),
    );
  }
}