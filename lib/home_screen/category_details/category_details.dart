import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home_screen/category_details/source/source_widget.dart';
import 'package:news/model/category.dart';
import 'package:news/model/source_response.dart';

import '../../global_widgets/main_error_widget.dart';
import '../../global_widgets/main_loading_widget.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;

  const CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        if (snapshot.hasError) {
          // todo :
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getSources(widget.category.id);
              setState(() {});
            },
            errorMessage: 'Something went Wrong ',
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data?.status != 'ok') {
            return MainErrorWidget(
              onPressed: () {
                ApiManager.getSources(widget.category.id);
                setState(() {});
              },
              errorMessage: snapshot.data!.message!,
            );
          }
        }
        var sourcesList = snapshot.data!.sources!;
        if (sourcesList.isEmpty) {
          return Center(
            child: Text(
              'no_news_sources_found'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        }
        return SourceWidget(sourcesList: sourcesList);
      },
    );
  }
}
