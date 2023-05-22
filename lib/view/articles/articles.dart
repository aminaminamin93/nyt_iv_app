import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iv_nyt_app/models/articles.models.dart';
import 'package:iv_nyt_app/helper/base_network.dart';
import 'package:iv_nyt_app/models/most_viewed_articles.models.dart';

import '../../services/article.services.dart';

class ArticlesWidget extends StatefulWidget {
  ArticlesWidget({Key? key, required this.category, required this.keyword}) : super(key:key);
  String? category;
  String? keyword;

  @override
  State<ArticlesWidget> createState() => _ArticlesWidgetState(category,keyword);
}

class _ArticlesWidgetState extends State<ArticlesWidget>{
  _ArticlesWidgetState(this.category,this.keyword);
  final String? category;
  final String? keyword;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final box = GetStorage('NytStorage');
  bool isStateReady = false;
  int currentCountPage = 20;
  int lengthCountPage = 0;
  List<Doc>? _docsData;

  Future _getDocs() async {

     List<Doc>? listDocs = await ArticleServices.getArticles(keyword);

    lengthCountPage = listDocs?.length ?? 0;
    if(currentCountPage >= lengthCountPage){
      _docsData = listDocs?.take(lengthCountPage).toList();
    }
    _docsData = listDocs?.take(currentCountPage).toList();

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
              title: Text('Articles')
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
                  title: Text('${_docsData?[i].headline.main}',
                                style: const TextStyle(
                                    fontSize: 20.0
                                ),
                              ),
                  // child: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text('${i+1}',
                  //         style: const TextStyle(
                  //             fontSize: 28.0
                  //         ),
                  //       ),
                  //       const SizedBox(width: 20,),
                  //       Expanded(
                  //           child: Text('${_docsData?[i].headline.main}',
                  //             style: const TextStyle(
                  //                 fontSize: 20.0
                  //             ),
                  //           )
                  //       )
                  //     ],
                  //   ),
                  // ),
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
      )
      //   FutureBuilder<List<Doc>>(
      //   future: _getDocs(),
      //   builder: (context, snapshot){
      //     if(!snapshot.hasData){
      //       return const Center(child: CircularProgressIndicator(value: 10,));
      //     }
      //
      //     // List<Doc> docs = snapshot.data.response.docs;
      //     return ListView.builder(
      //       itemCount: snapshot.data?.length,
      //       controller: _scrollController,
      //       itemBuilder: (BuildContext, i) {
      //         return Card(
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Expanded(child: Text('${snapshot.data?[i].abstract}'))
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      //
      // ),

    );
  }
}
