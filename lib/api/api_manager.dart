import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';

class ApiManager {
  /*
  https://newsapi.org/v2/top-headlines/sources?apiKey=e4c38ad7e2e8498a9dd56abb588c971c

   */

  static Future<SourceResponse>getSources(String categoryId) async{
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
      'category' : categoryId,
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


  /*
  https://newsapi.org/v2/everything?apiKey=e4c38ad7e2e8498a9dd56abb588c971c

   */

static Future<NewsResponse> getNewsBySourceId(String sourceId  , int pageNum)async{
 Uri url = Uri.https(ApiConstants.baseUrl , EndPoints.newsApi , {
   "apiKey" : ApiConstants.apiKey ,
   "sources" : sourceId ,
   "pageSize" : '10' ,
   "page" : '$pageNum' ,

 });
 try {
   var response = await http.get(url);
   var responseBody = response.body;
   var json = jsonDecode(responseBody);
   return NewsResponse.fromJson(json);
 }
 catch (e){

   rethrow;
 }



}
}
