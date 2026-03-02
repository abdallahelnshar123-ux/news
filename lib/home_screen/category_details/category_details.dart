import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/api/dio/dio_manager.dart';
import 'package:news/home_screen/category_details/source/source_widget.dart';
import 'package:news/model/category.dart';
import 'package:news/model/source_response.dart';



import '../../global_widgets/main_error_widget.dart';
import '../../global_widgets/main_loading_widget.dart';

class CategoryDetails extends StatefulWidget {
  final Category category ;
  const CategoryDetails({super.key , required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: DioManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        if (snapshot.hasError) {
          // todo :
          return MainErrorWidget(
            onPressed: () {
              DioManager.getSources(widget.category.id);
              setState(() {});
            },
            errorMessage: 'Something went Wrong ',
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data?.status != 'ok') {
            return MainErrorWidget(
              onPressed: () {
                DioManager.getSources(widget.category.id);
                setState(() {});
              },
              errorMessage: snapshot.data!.message!,
            );
          }
        }
        var sourcesList = snapshot.data!.sources!;
        return SourceWidget(sourcesList: sourcesList);
      },
    );
  }
}
