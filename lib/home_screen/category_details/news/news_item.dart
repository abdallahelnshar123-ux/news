import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/screen_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

import '../../../global_widgets/main_loading_widget.dart';
import '../../../model/news_response.dart';

class NewsItem extends StatelessWidget {
  final News news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.02),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.isLight ? AppColors.blackColor : AppColors.whiteColor,
          width: 1,
        ),
      ),
      child: Column(
        spacing: context.height * 0.02,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage ?? '',
              placeholder: (context, url) => MainLoadingWidget(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(
            news.title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'by : ${news.author ?? 'No author'}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Text(
                publishTime(context),
                // news.publishedAt ?? '',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String publishTime(BuildContext context) {
    DateTime parsedDate = DateTime.parse(
      news.publishedAt ?? '${DateTime.now()}',
    );
    return timeago.format(parsedDate, locale: context.locale.countryCode);
  }
}
