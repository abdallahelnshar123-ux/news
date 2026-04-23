import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/home_screen/search/search_news_widget.dart';

import '../../global_widgets/custom_text_field.dart';
import '../../provider/app_theme_provider.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_assets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? debounce;
  String? query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: CustomTextField(
          onChanged: (text) {
            if (debounce?.isActive ?? false) debounce!.cancel();

            debounce = Timer(const Duration(milliseconds: 500), () {
              setState(() {
                query = text;
              });
            });
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
              context.isLight ? AppColors.blackColor : AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: context.isLight
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
            ),
          ),
        ),
      ),
      body: SearchResultNews(searchKeyWord: query),
    );
  }
}
