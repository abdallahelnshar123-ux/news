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

  static List<Category> getCategoryList() {
    return categoriesNames
        .map(
          (category) => Category(
            id: category,
            title: category[0].toUpperCase() + category.substring(1),
            image: 'assets/images/${category}_dark.png',
          ),
        )
        .toList();
  }
}
