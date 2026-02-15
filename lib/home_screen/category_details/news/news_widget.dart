import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/screen_size.dart';

import '../../../global_widgets/main_error_widget.dart';
import '../../../global_widgets/main_loading_widget.dart';

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
        return ListView.separated(
          padding: EdgeInsets.all(context.width * 0.03),
          separatorBuilder: (context, index) =>
              SizedBox(height: context.width * 0.04),
          itemBuilder: (context, index) {
            return NewsItem(news: newsList[index]);
          },
          itemCount: newsList.length,

        );

      },
    );
  }
}
