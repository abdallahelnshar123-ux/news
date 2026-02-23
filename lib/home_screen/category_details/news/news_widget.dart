import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home_screen/category_details/news/bottom_sheet_news_widget.dart';
import 'package:news/home_screen/category_details/news/page_navigation_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/screen_size.dart';

import '../../../global_widgets/main_error_widget.dart';
import '../../../global_widgets/main_loading_widget.dart';

import '../../../utils/app_Colors.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key, required this.source});

  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  int pageNum = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse>(
      future: ApiManager.getNewsBySourceId(widget.source.id ?? '', pageNum),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        if (snapshot.hasError) {
          // todo :
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getNewsBySourceId(widget.source.id ?? '', pageNum);
              setState(() {});
            },
            errorMessage: 'Something went Wrong ',
          );
        }

        if (snapshot.data?.status != 'ok') {
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getNewsBySourceId(widget.source.id ?? '', pageNum);
              setState(() {});
            },
            errorMessage: snapshot.data!.message!,
          );
        }

        var newsList = snapshot.data!.articles!;
        return newsList.isEmpty
            ? Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.only(top: context.height * 0.35),
                child: Text(
                  context.tr('no_news_from_this_source'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            : Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        //       shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(context.width * 0.03),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: context.width * 0.04),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              onNewsClick(newsList[index]);
                            },
                            child: NewsItem(news: newsList[index]),
                          );
                        },
                        itemCount: newsList.length,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PageNavigationWidget(
                          visibility: newsList.isNotEmpty,

                          pageNum: pageNum,
                          onPressed: () {
                            if (newsList.isNotEmpty) {
                              pageNum++;
                              setState(() {});
                            }
                          },
                          text: 'next_page',
                        ),
                        PageNavigationWidget(
                          visibility: pageNum>1,
                          pageNum: pageNum,
                          onPressed: () {
                            if (pageNum > 1) {
                              pageNum--;
                              setState(() {});
                            }
                          },
                          text: 'previous_page',
                        ),
                      ],
                    ),
                  ],
                ),
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
}
