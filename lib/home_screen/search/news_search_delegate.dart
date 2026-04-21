import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/home_screen/search/search_news_widget.dart';

import '../../provider/app_theme_provider.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_assets.dart';

class NewsSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // IconButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   icon: Icon(
      //     Icons.close,
      //     color: context.isLight ? AppColors.blackColor : AppColors.whiteColor,
      //   ),
      // ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => showResults(context),
      icon: SvgPicture.asset(
        fit: BoxFit.scaleDown,
        AppAssets.searchIconDark,
        colorFilter: ColorFilter.mode(
          context.isLight ? AppColors.blackColor : AppColors.whiteColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultNews(searchKeyWord: query);

    //   FutureBuilder<SourceResponse>(
    //   future: ApiManager.getAllSources(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MainLoadingWidget();
    //     }
    //     if (snapshot.hasError) {
    //       return MainErrorWidget(
    //         onPressed: () {
    //           ApiManager.getAllSources();
    //         },
    //         errorMessage: 'Something went Wrong ',
    //       );
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.data?.status != 'ok') {
    //         return MainErrorWidget(
    //           onPressed: () {
    //             ApiManager.getAllSources();
    //           },
    //           errorMessage: snapshot.data!.message!,
    //         );
    //       }
    //     }
    //     var sourcesList = snapshot.data!.sources!;
    //     return SearchSourceWidget(sourcesList: sourcesList, keyWord: query);
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor:
      context.isLight ? AppColors.whiteColor : AppColors.blackColor,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      inputDecorationTheme: InputDecorationTheme(

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        filled: true,
        fillColor:
        context.isLight ? AppColors.whiteColor : AppColors.blackColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.isLight
                ? AppColors.blackColor
                : AppColors.whiteColor,
            width: 2,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.isLight
                ? AppColors.blackColor
                : AppColors.whiteColor,
            width: 2,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: context.isLight
                ? AppColors.blackColor
                : AppColors.whiteColor,
            width: 2,
          ),
        ),
      ),
    );
  }

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return Theme.of(context).copyWith(
  //    inputDecorationTheme: InputDecorationTheme(
  //
  //    ),
  //     appBarTheme: AppBarThemeData(
  //
  //       backgroundColor: context.isLight
  //           ? AppColors.whiteColor
  //           : AppColors.blackColor,
  //       // shape: RoundedRectangleBorder(
  //       //   borderRadius: BorderRadius.circular(16),
  //       //   side: BorderSide(
  //       //     width: 2,
  //       //     color: context.isLight
  //       //         ? AppColors.blackColor
  //       //         : AppColors.whiteColor,
  //       //   ),
  //       // ),
  //     ),
  //   );
  // }
}
