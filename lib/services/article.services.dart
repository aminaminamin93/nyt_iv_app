import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:iv_nyt_app/models/articles.models.dart';
import 'package:iv_nyt_app/helper/base_network.dart';
import '../models/most_viewed_articles.models.dart';

class ArticleServices {
  static Future<bool> getConnection() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }else{
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<List<Doc>?> getArticles(keyword) async{
    ArticlesResponse? obj = ArticlesResponse();
    ResponseData? responseData;
    List<Doc>? listDocs;

    if(await getConnection() == false) {
      return GetStorage().read('search_articles');
    }

    final network = await BaseNetwork.network();
    await network.get('/svc/search/v2/articlesearch.json?q=${keyword}&api-key=wG90i4wCgA9lP2VD4SGPU5PCTI4xvLWl')
        .then((res) {
      obj = ArticlesResponse.fromJson(res.data);
      responseData = obj?.response;
      listDocs = responseData?.docs;
      if(responseData?.docs != null){
        GetStorage().write('search_articles', responseData?.docs);
      }
    })
    .catchError((error) { print(error); });

    return listDocs;
  }

  static Future<List<MostViewedResult>?> getMostPopularArticles(type) async{

    MostViewedArticlesResponse? obj;
    List<MostViewedResult>? mostViewedResult;
    if(await getConnection() == false) {
      return GetStorage().read('${type}_articles');
    }

    final network = await BaseNetwork.network();
    await network.get('/svc/mostpopular/v2/$type/7.json?api-key=wG90i4wCgA9lP2VD4SGPU5PCTI4xvLWl')
        .then((res) {
      obj = MostViewedArticlesResponse.fromJson(res.data);
      mostViewedResult = obj?.results;
      GetStorage().write('viewed_articles', mostViewedResult);
    })
        .catchError((error) { print(error); });

    return mostViewedResult;
  }
  
}