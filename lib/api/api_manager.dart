import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/source_response.dart';

class ApiManager {
  /*
  https://newsapi.org/v2/top-headlines/sources?apiKey=e4c38ad7e2e8498a9dd56abb588c971c

   */

  static Future<SourceResponse>getSources() async{
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    }
    catch (e){
rethrow ;


    }
  }
}
