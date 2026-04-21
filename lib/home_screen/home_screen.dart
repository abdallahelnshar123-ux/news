import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/home_screen/categories_widget/categories_widget.dart';
import 'package:news/home_screen/category_details/category_details.dart';
import 'package:news/home_screen/drawer/home_drawer.dart';
import 'package:news/model/category.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/screen_size.dart';
import 'package:provider/provider.dart';

import '../provider/source_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categoryList = [];

  String keyWord = '';

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
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.searchRouteName),
            icon: SvgPicture.asset(
              context.isLight
                  ? AppAssets.searchIconLight
                  : AppAssets.searchIconDark,
            ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
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
    context.read<SourceProvider>().changeIndex(0);
    setState(() {});
  }

  void onGoHomeTap() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
