import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_colors.dart';

import '../../utils/screen_size.dart';

class ViewAllWidget extends StatelessWidget {
  final int index;

  const ViewAllWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: index % 2 == 0
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.isLight ?  AppColors.white50OpacityColor:AppColors.black50OpacityColor ,
            borderRadius: BorderRadius.circular(84),
          ),
          width: context.width * 0.45,
          height: context.height * 0.07,
        ),
        Row(

          spacing: context.width * 0.05,
          children: index % 2 == 0
              ? [
                  Text(
                    context.tr('view_all'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: context.isLight? AppColors.whiteColor:  AppColors.blackColor,
                      borderRadius: BorderRadius.circular(84),
                    ),
                    width: context.height * 0.07,
                    height: context.height * 0.07,
                    child: Icon(
                      index % 2 == 0
                          ? Icons.arrow_forward_ios
                          : Icons.arrow_back_ios,
                      color: context.isLight ?AppColors.blackColor :AppColors.whiteColor,
                      size: context.width * 0.08,
                    ),
                  ),
                ]
              : [
                  Container(
                    decoration: BoxDecoration(
                      color: context.isLight? AppColors.whiteColor:  AppColors.blackColor,
                      borderRadius: BorderRadius.circular(84),
                    ),
                    width: context.height * 0.07,
                    height: context.height * 0.07,
                    child: Icon(
                      index % 2 == 0
                          ? Icons.arrow_forward_ios
                          : Icons.arrow_back_ios,
                      color: context.isLight ?AppColors.blackColor :AppColors.whiteColor,
                      size: context.width * 0.08,
                    ),
                  ),
                  Text(
                    context.tr('view_all'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
        ),
      ],
    );
  }
}
