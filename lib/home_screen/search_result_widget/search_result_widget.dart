import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home_screen/category_details/source/source_widget.dart';
import 'package:news/home_screen/search_result_widget/search_source_widget.dart';
import 'package:news/model/category.dart';
import 'package:news/model/source_response.dart';



import '../../global_widgets/main_error_widget.dart';
import '../../global_widgets/main_loading_widget.dart';

class SearchResultWidget extends StatefulWidget {
  // final Category category ;
  final String keyWord;
  const SearchResultWidget({super.key , required this.keyWord });

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getAllSources(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        if (snapshot.hasError) {
          // todo :
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getAllSources();
              setState(() {});
            },
            errorMessage: 'Something went Wrong ',
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data?.status != 'ok') {
            return MainErrorWidget(
              onPressed: () {
                ApiManager.getAllSources();
                setState(() {});
              },
              errorMessage: snapshot.data!.message!,
            );
          }
        }
        var sourcesList = snapshot.data!.sources!;
        return SearchSourceWidget(sourcesList: sourcesList , keyWord: widget.keyWord);
      },
    );
  }
}
