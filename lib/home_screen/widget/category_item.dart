import 'package:flutter/material.dart';
import 'package:news/model/category.dart';
import 'package:news/utils/screen_size.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  int index;

  CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(category.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: index % 2 == 0
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height * 0.04,
                horizontal: context.width * 0.1),
            child: Column(
              children: [
                Text(
                  category.title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .displayMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
