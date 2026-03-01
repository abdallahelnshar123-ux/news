import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home_screen/category_details/news/cubit/news_states.dart';
import 'package:news/model/news_response.dart';

class NewsViewModel extends Cubit<NewsStates> {
  NewsViewModel() : super(NewsLoadingState());

  List<News>? newsList;

  String? errorMessage;

  void getNewsBySourceId(String sourceId, int pageNum) async {
    try {
      emit(NewsLoadingState());
      var response = await ApiManager.getNewsBySourceId(sourceId, pageNum);
      if (response.status == 'error') {
        errorMessage = response.message;
        emit(NewsErrorState());
        return;
      }
      if (response.status == 'ok') {
        newsList = response.articles!;
        emit(NewsSuccessState());
        return;
      }
    } catch (e) {
      errorMessage = e.toString();
      emit(NewsErrorState());
    }
  }
}
