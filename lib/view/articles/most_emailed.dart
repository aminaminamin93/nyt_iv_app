import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iv_nyt_app/services/article.services.dart';
import '../../models/most_viewed_articles.models.dart';

class MostViewedArticles extends StatefulWidget {
  const MostViewedArticles({Key? key}) : super(key: key);

  @override
  State<MostViewedArticles> createState() => _MostViewedArticlesState();
}

class _MostViewedArticlesState extends State<MostViewedArticles> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage('NytStorage');
  bool isStateReady = false;
  int currentCountPage = 20;
  int lengthCountPage = 0;
  List<MostViewedResult>? _docsData;

  Future _getDocs() async {
    List<MostViewedResult>? _docs = await ArticleServices.getMostPopularArticles('emailed');
    // List<MostViewedResult> _docs = box.read('most_viewed_articles');

    lengthCountPage = _docs?.length ?? 0;
    if(currentCountPage >= lengthCountPage){
      _docsData = _docs?.take(lengthCountPage).toList();
    }
    _docsData = _docs?.take(currentCountPage).toList();

    if(_docsData != null){
      setState(() {
        isStateReady = true;
        currentCountPage = currentCountPage + 20;
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
    super.dispose();

    box.erase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Most View Articles')
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
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            ] else if (currentCountPage >= lengthCountPage) ...[
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text('You have fetch all article'),
              )
            ]
          ],
        ),
    );
  }
}
