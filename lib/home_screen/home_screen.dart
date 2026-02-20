import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/home_screen/categories_widget/categories_widget.dart';
import 'package:news/home_screen/category_details/category_details.dart';
import 'package:news/home_screen/drawer/home_drawer.dart';
import 'package:news/model/category.dart';
import 'package:news/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categoryList = [];

  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    categoryList = Category.getCategoryList(context);
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: HomeDrawer(onTap: onGoHomeTap),
      ),
      appBar: AppBar(
        title: Text(
          selectedCategory == null
              ? context.tr('home')
              : context.tr(selectedCategory!.id),
        ),
      ),
      body: selectedCategory == null
          ? CategoriesWidget(
              categoryList: categoryList,
              onCategoryItemClick: onCategoryItemClick,
            )
          : CategoryDetails(category: selectedCategory!),
    );
  }

  void onCategoryItemClick(Category newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  void onGoHomeTap() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
