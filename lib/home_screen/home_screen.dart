import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/global_widgets/custom_text_field.dart';
import 'package:news/home_screen/categories_widget/categories_widget.dart';
import 'package:news/home_screen/category_details/category_details.dart';
import 'package:news/home_screen/drawer/home_drawer.dart';
import 'package:news/home_screen/search_result_widget/search_result_widget.dart';
import 'package:news/model/category.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/provider/source_provider.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/screen_size.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categoryList = [];
  bool search = false;
  String keyWord = '';

  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    context.read<SourceProvider>().changeIndex(0);
    categoryList = Category.getCategoryList(context);
    return Scaffold(
      drawer: search
          ? null
          : Drawer(
              backgroundColor: AppColors.blackColor,
              child: HomeDrawer(onTap: onGoHomeTap),
            ),
      appBar: AppBar(
        automaticallyImplyLeading: !search,
        automaticallyImplyActions: !search,
        title: search
            ? CustomTextField(
                onChanged: (text) {
                  keyWord = text;
                  setState(() {});
                },
                dataStyle: Theme.of(context).textTheme.titleLarge,
                errorBorderColor: Colors.red,
                generalBorderColor: context.isLight
                    ? AppColors.blackColor
                    : AppColors.whiteColor,
                prefixIcon: SvgPicture.asset(
                  fit: BoxFit.scaleDown,
                  AppAssets.searchIconDark,
                  colorFilter: ColorFilter.mode(
                    context.isLight
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    search = false;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.close,
                    color: context.isLight
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                  ),
                ),
              )
            : Text(
                selectedCategory == null
                    ? context.tr('home')
                    : context.tr(selectedCategory!.id),
              ),
        actions: search
            ? null
            : [
                IconButton(
                  onPressed: () {
                    search = true;
                    setState(() {});
                  },
                  icon: SvgPicture.asset(
                    context.isLight
                        ? AppAssets.searchIconLight
                        : AppAssets.searchIconDark,
                  ),
                ),
              ],
        actionsPadding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
      ),
      body: showBodyWidget(),
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

  Widget showBodyWidget() {
    if (search) {
      return SearchResultWidget(keyWord: keyWord);
    }
    if (selectedCategory == null) {
      return CategoriesWidget(
        categoryList: categoryList,
        onCategoryItemClick: onCategoryItemClick,
      );
    }
    return CategoryDetails(category: selectedCategory!);
  }
}
