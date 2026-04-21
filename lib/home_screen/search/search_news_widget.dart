import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home_screen/category_details/news/bottom_sheet_news_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/utils/screen_size.dart';

import '../../../global_widgets/main_loading_widget.dart';

import '../../../utils/app_Colors.dart';
import '../category_details/news/news_item.dart';

class SearchResultNews extends StatefulWidget {
  const SearchResultNews({super.key, required this.searchKeyWord });

  final String searchKeyWord;

  @override
  State<SearchResultNews> createState() => _SearchResultNewsState();
}

class _SearchResultNewsState extends State<SearchResultNews> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  int pageNum = 1;
  List<News> newsList = [];

  @override
  void initState() {
    scrollController.addListener(onScroll);
    super.initState();
    if (newsList.isNotEmpty) return;
    loadNews();
  }

  @override
  void didUpdateWidget(covariant SearchResultNews oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.searchKeyWord != widget.searchKeyWord) {
      pageNum = 1;
      newsList.clear();
      loadNews();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (newsList.isEmpty && isLoading) {
      return Center(child: MainLoadingWidget());
    }

    if (newsList.isEmpty) {
      return Center(
        child: Text(
          context.tr('no_news_found'),
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
      );
    }

    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.all(context.width * 0.03),
      separatorBuilder: (context, index) =>
          SizedBox(height: context.width * 0.04),
      itemCount: newsList.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == newsList.length) {
          return Center(child: CircularProgressIndicator());
        }

        return GestureDetector(
          onTap: () => onNewsClick(newsList[index]),
          child: NewsItem(news: newsList[index]),
        );
      },
    );
  }

  void onNewsClick(News selectedNews) {
    showModalBottomSheet(
      backgroundColor: AppColors.transparentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      context: context,
      builder: (context) => BottomSheetNewsWidget(selectedNews: selectedNews),
    );
  }

  void onScroll() {
    if (isLoading) return;
    final double pixels = scrollController.position.pixels;
    final double maxScroll = scrollController.position.maxScrollExtent;
    final int triggerDistance = context.height ~/ 4;
    if (pixels >= maxScroll - triggerDistance) {
      loadNews();
    }
  }

  Future<void> loadNews() async {
    final currentSearchKeyWord = widget.searchKeyWord;

    setState(() => isLoading = true);

    final response = await ApiManager.getNewsBySearch(
        pageNum, currentSearchKeyWord);

    if (!mounted || currentSearchKeyWord != widget.searchKeyWord) return;

    if (response.status == 'ok') {
      setState(() {
        newsList.addAll(response.articles!);
        pageNum++;
      });
    }

    setState(() => isLoading = false);
  }
}


// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:news/api/api_manager.dart';
// import 'package:news/home_screen/category_details/news/bottom_sheet_news_widget.dart';
// import 'package:news/home_screen/category_details/news/page_navigation_widget.dart';
// import 'package:news/model/news_response.dart';
// import 'package:news/model/source_response.dart';
// import 'package:news/utils/screen_size.dart';
//
// import '../../../global_widgets/main_error_widget.dart';
// import '../../../global_widgets/main_loading_widget.dart';
//
// import '../../../utils/app_Colors.dart';
// import '../category_details/news/news_item.dart';
//
// class SearchNewsWidget extends StatefulWidget {
//   const SearchNewsWidget({
//     super.key,
//     required this.source,
//     required this.keyWord,
//   });
//
//   final Source source;
//   final String keyWord;
//
//   @override
//   State<SearchNewsWidget> createState() => _SearchNewsWidgetState();
// }
//
// class _SearchNewsWidgetState extends State<SearchNewsWidget> {
//   int pageNum = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<NewsResponse>(
//       future: ApiManager.getNewsBySearch(
//         widget.source.id ?? '',
//         pageNum,
//         widget.keyWord,
//       ),
//       // ApiManager.getNewsBySourceId(widget.source.id ?? '', pageNum),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return MainLoadingWidget();
//         }
//         if (snapshot.hasError) {
//           // todo :
//           return MainErrorWidget(
//             onPressed: () {
//               ApiManager.getNewsBySearch(
//                 widget.source.id ?? '',
//                 pageNum,
//                 widget.keyWord,
//               );
//               // ApiManager.getNewsBySourceId(widget.source.id ?? '', pageNum);
//               setState(() {});
//             },
//             errorMessage: 'Something went Wrong ',
//           );
//         }
//
//         if (snapshot.data?.status != 'ok') {
//           return MainErrorWidget(
//             onPressed: () {
//               ApiManager.getNewsBySearch(
//                 widget.source.id ?? '',
//                 pageNum,
//                 widget.keyWord,
//               );
//               // ApiManager.getNewsBySourceId(widget.source.id ?? '', pageNum);
//               setState(() {});
//             },
//             errorMessage: snapshot.data!.message!,
//           );
//         }
//
//         var newsList = snapshot.data!.articles!;
//         return newsList.isEmpty
//             ? Container(
//                 alignment: Alignment.center,
//                 width: double.infinity,
//                 padding: EdgeInsets.only(top: context.height * 0.35),
//                 child: Text(
//                   context.tr('no_news_from_this_source'),
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               )
//             : Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Expanded(
//                       child: ListView.separated(
//                         //       shrinkWrap: true,
//                         // physics: NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.all(context.width * 0.03),
//                         separatorBuilder: (context, index) =>
//                             SizedBox(height: context.width * 0.04),
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               onNewsClick(newsList[index]);
//                             },
//                             child: NewsItem(news: newsList[index]),
//                           );
//                         },
//                         itemCount: newsList.length,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         PageNavigationWidget(
//                           visibility: newsList.isNotEmpty,
//
//                           pageNum: pageNum,
//                           onPressed: () {
//                             if (newsList.isNotEmpty) {
//                               pageNum++;
//                               setState(() {});
//                             }
//                           },
//                           text: 'next_page',
//                         ),
//                         PageNavigationWidget(
//                           visibility: pageNum > 1,
//                           pageNum: pageNum,
//                           onPressed: () {
//                             if (pageNum > 1) {
//                               pageNum--;
//                               setState(() {});
//                             }
//                           },
//                           text: 'previous_page',
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//       },
//     );
//   }
//
//   void onNewsClick(News selectedNews) {
//     showModalBottomSheet(
//       backgroundColor: AppColors.transparentColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       clipBehavior: Clip.antiAlias,
//       context: context,
//       builder: (context) => BottomSheetNewsWidget(selectedNews: selectedNews),
//     );
//   }
// }
