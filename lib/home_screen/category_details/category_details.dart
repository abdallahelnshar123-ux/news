import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/home_screen/category_details/cubit/source_states.dart';
import 'package:news/home_screen/category_details/cubit/source_view_model.dart';
import 'package:news/home_screen/category_details/source/source_widget.dart';
import 'package:news/model/category.dart';

import '../../global_widgets/main_error_widget.dart';
import '../../global_widgets/main_loading_widget.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;

  const CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  SourceViewModel viewModel = SourceViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceViewModel, SourceState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is SourceLoadingState) {
          return MainLoadingWidget();
        } else if (state is SourceErrorState) {
          return MainErrorWidget(
            errorMessage: viewModel.errorMessage!,
            onPressed: () {
              viewModel.getSources(widget.category.id);
            },
          );
        } else if (state is SourceSuccessState) {
          return SourceWidget(sourcesList: viewModel.sourceList ?? [] );
        }
        return Container();
      },
    );

    //   FutureBuilder<SourceResponse>(
    //   future: ApiManager.getSources(widget.category.id),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MainLoadingWidget();
    //     }
    //     if (snapshot.hasError) {
    //       // todo :
    //       return MainErrorWidget(
    //         onPressed: () {
    //           ApiManager.getSources(widget.category.id);
    //           setState(() {});
    //         },
    //         errorMessage: 'Something went Wrong ',
    //       );
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.data?.status != 'ok') {
    //         return MainErrorWidget(
    //           onPressed: () {
    //             ApiManager.getSources(widget.category.id);
    //             setState(() {});
    //           },
    //           errorMessage: snapshot.data!.message!,
    //         );
    //       }
    //     }
    //     var sourcesList = snapshot.data!.sources!;
    //     return SourceWidget(sourcesList: sourcesList);
    //   },
    // );
  }
}
