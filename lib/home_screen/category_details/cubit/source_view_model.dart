import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home_screen/category_details/cubit/source_states.dart';
import 'package:news/model/source_response.dart';

class SourceViewModel extends Cubit<SourceState> {
  SourceViewModel() : super(SourceLoadingState());

  List<Source>? sourceList;

  String? errorMessage;

  void getSources(String categoryId) async {
    try {
      emit(SourceLoadingState());
      var response = await ApiManager.getSources(categoryId);
      if (response.status == 'error') {
        errorMessage = response.message!;
        emit(SourceErrorState());
        return;
      } else {
        sourceList = response.sources ?? [];
        emit(SourceSuccessState());
        return;
      }
    } catch (e) {
      errorMessage = e.toString();
      emit(SourceErrorState());
    }
  }
}
