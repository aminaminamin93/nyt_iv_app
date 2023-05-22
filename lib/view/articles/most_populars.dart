import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iv_nyt_app/services/article.services.dart';
import '../../models/most_viewed_articles.models.dart';

class MostPopularArticles extends StatefulWidget {
  MostPopularArticles({Key? key,required this.type, required this.title}) :super(key:key);
  String? type;
  dynamic title;

  @override
  State<MostPopularArticles> createState() => _MostPopularArticlesState(type, title);
}

class _MostPopularArticlesState extends State<MostPopularArticles> {
  _MostPopularArticlesState(this.type, this.title);
  String? type;
  dynamic title;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage('NytStorage');
  bool isStateReady = false;
  int currentCountPage = 10;
  int lengthCountPage = 0;
  List<MostViewedResult>? _docsData;

  Future _getDocs() async {
    List<MostViewedResult>? listDocs = await ArticleServices.getMostPopularArticles(type);
    // List<MostViewedResult> _docs = box.read('most_viewed_articles');

    lengthCountPage = listDocs?.length ?? 0;
    if(currentCountPage >= lengthCountPage){
      _docsData = listDocs?.take(lengthCountPage).toList();
    }
    _docsData = listDocs?.take(currentCountPage).toList();

    if(_docsData != null){
      setState(() {
        isStateReady = true;
        currentCountPage = currentCountPage + 10;
      });
    }
  }
  @override
  void initState() {

    _getDocs();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){

        setState(() {
          isStateReady = false;
        });
        _getDocs();
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    box.erase();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            centerTitle: true,
            title: Text(title)
        ),
        body: Column(
          children: [
            Expanded(
              child: (isStateReady == false && _docsData == null)
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _docsData?.length ?? 0,
                controller: _scrollController,
                itemBuilder: (BuildContext, i) {
                  return ListTile(
                    shape: const Border(top: BorderSide(color: Colors.black)),
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text('${_docsData?[i].title}',
                      style: const TextStyle(
                          fontSize: 20.0
                      ),
                    ),
                  );
                },
              ),
            ),


            if (isStateReady == false && _docsData != null) ...[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            ]



          ],
        )

    );
  }
}
