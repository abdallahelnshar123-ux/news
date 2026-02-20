import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/model/category.dart';

import '../../utils/screen_size.dart';
import '../widget/category_item.dart';

typedef OnCategoryItemClick = void Function(Category);

class CategoriesWidget extends StatelessWidget {
  final OnCategoryItemClick onCategoryItemClick;

  final List<Category> categoryList;

  const CategoriesWidget({
    super.key,
    required this.categoryList,
    required this.onCategoryItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
      child: Column(
        spacing: context.height * 0.015,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.tr('good_morning'), style: Theme.of(context).textTheme.displayLarge),
          FittedBox(
            alignment: AlignmentDirectional.centerStart,
            fit: BoxFit.scaleDown,
            child: Text(
              context.tr('here_is_Some_news_for_you'),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          ListView.separated(
            padding: EdgeInsets.symmetric(vertical: context.height*0.02),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                onCategoryItemClick(categoryList[index]);
              },
              child: CategoryItem(index: index, category: categoryList[index]),
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: context.height * 0.02),
            itemCount: categoryList.length,
          ),
        ],
      ),
    );
  }
}
