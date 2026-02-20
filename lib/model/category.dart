import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_assets.dart';

class Category {
  String id;

  String title;
  String image;
  static List<String> categoriesNames = [
    "general",
    "business",
    "entertainment",
    "health",
    "science",
    "technology",
    "sports",
  ];

  Category({required this.id, required this.title, required this.image});

  static List<Category> getCategoryList(BuildContext context) {
    return categoriesNames
        .map(
          (category) => Category(
            id: category,
            title: context.tr(category),
            image: context.isLight ?'assets/images/${category}_light.png' :'assets/images/${category}_dark.png',
          ),
        )
        .toList();
  }
}
