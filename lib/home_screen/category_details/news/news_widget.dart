import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home_screen/category_details/news/bottom_sheet_news_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/screen_size.dart';

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
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.source.id != widget.source.id) {
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
      return MainLoadingWidget();
    }

    if (newsList.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            context.tr('no_news_from_this_source'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
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
      ),
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
    final currentSourceId = widget.source.id;

    setState(() => isLoading = true);

    final response = await ApiManager.getNewsBySourceId(
      currentSourceId ?? '',
      pageNum,
    );

    if (!mounted || currentSourceId != widget.source.id) return;

    if (response.status == 'ok') {
      setState(() {
        newsList.addAll(response.articles!);
        pageNum++;
      });
    }

    setState(() => isLoading = false);
  }
}
