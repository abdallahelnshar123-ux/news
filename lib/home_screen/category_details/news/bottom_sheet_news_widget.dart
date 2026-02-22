import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/global_widgets/custom_elevated_button.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/app_styles.dart';
import 'package:readmore/readmore.dart';
import '../../../global_widgets/main_loading_widget.dart';
import '../../../model/news_response.dart';
import '../../../utils/screen_size.dart';

class BottomSheetNewsWidget extends StatelessWidget {
  final News selectedNews;

  const BottomSheetNewsWidget({super.key, required this.selectedNews});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16),
        color: context.isLight ? AppColors.blackColor : AppColors.whiteColor,
      ),
      margin: EdgeInsets.only(bottom: 20),

      padding: EdgeInsets.all(context.width * 0.025),
      child:
          // selectedNews == null ? :
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: context.height * 0.015,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: selectedNews.urlToImage ?? '',
                  placeholder: (context, url) => MainLoadingWidget(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              ReadMoreText(
                selectedNews.description ?? selectedNews.title!,
                trimMode: TrimMode.Length,
                trimLength: 120,
                style: context.isLight
                    ? AppStyles.medium14white
                    : AppStyles.medium14black,
                trimCollapsedText: trimCollapsedText(context),
                // '[+${selectedNews.description!.length -110} chars]',
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.webviewRouteName,
                    arguments: selectedNews.url,
                  );
                  // Navigator.pop(context);
                },
                backgroundColor: context.isLight
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
                child: Text(
                  context.tr('view_full_article'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
    );
  }

  String trimCollapsedText(BuildContext context) {
    if (selectedNews.description != null) {
      if (selectedNews.description!.length <= 120) {
        return '';
      }
      return '[+${selectedNews.description!.length - 120} ${context.tr('chars')}]';
    }
    return selectedNews.title ?? 'No Title';
  }
}
