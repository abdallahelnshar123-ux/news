import 'package:dio/dio.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../api_constants.dart';

class DioManager {
  static final dio =
      Dio(
          BaseOptions(
            baseUrl: 'https://newsapi.org',
            queryParameters: {'apiKey': ApiConstants.apiKey},
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            responseBody: true,
            requestBody: true,
            responseHeader: true,
            error: true,
          ),
        );

  /*
  https://newsapi.org/v2/top-headlines/sources?apiKey=e4c38ad7e2e8498a9dd56abb588c971c

   */
  static Future<SourceResponse> getSources(String categoryId) async {
    try {
      var response = await dio.get(
        EndPoints.sourceApi,
        queryParameters: {'category': categoryId},
      );
      var json = response.data;
      return SourceResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  /*
  https://newsapi.org/v2/everything?apiKey=e4c38ad7e2e8498a9dd56abb588c971c

   */
  static Future<NewsResponse> getNewsBySourceId(
    String sourceId,
    int pageNum,
  ) async {
    try {
      var response = await dio.get(
        EndPoints.newsApi,
        queryParameters: {
          'sources': sourceId,
          "pageSize": '10',
          "page": '$pageNum',
        },
      );
      var json = response.data;
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
