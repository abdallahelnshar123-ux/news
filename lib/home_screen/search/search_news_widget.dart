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
  const SearchResultNews({super.key, required this.searchKeyWord});

  final String? searchKeyWord;

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

    if (widget.searchKeyWord == null || widget.searchKeyWord == '') {
      return Center(
        child: Text(
          context.tr('start_search'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }
    if (newsList.isEmpty) {
      return Center(
        child: Text(
          context.tr('no_news_found'),
          style: Theme.of(context).textTheme.titleMedium,
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
    if (currentSearchKeyWord != null) {
      setState(() => isLoading = true);

      final response = await ApiManager.getNewsBySearch(
        pageNum,
        currentSearchKeyWord,
      );

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
}
