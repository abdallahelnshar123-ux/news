import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home_screen/category_details/news/bottom_sheet_news_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse>(
      future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        if (snapshot.hasError) {
          // todo :
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getNewsBySourceId(widget.source.id ?? '');
              setState(() {});
            },
            errorMessage: 'Something went Wrong ',
          );
        }

        if (snapshot.data?.status != 'ok') {
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getNewsBySourceId(widget.source.id ?? '');
              setState(() {});
            },
            errorMessage: snapshot.data!.message!,
          );
        }

        var newsList = snapshot.data!.articles!;
        return newsList.isEmpty
            ? Center(
                child: Text(
                  context.tr('no_news_from_this_source'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            : ListView.separated(
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
