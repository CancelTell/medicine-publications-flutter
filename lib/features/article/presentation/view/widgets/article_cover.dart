import 'package:flutter/cupertino.dart';

import '../../../domain/article_model.dart';
import '../../utils/article_format.dart';

class ArticleCover extends StatelessWidget{
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
      child: Image.asset(article.cover, width: size * 0.6, height: size * 0.6,),
    );
  }
}