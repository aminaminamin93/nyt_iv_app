import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iv_nyt_app/view/articles/articles.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Search'),
        ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              TextFormField(
                controller: searchTextController,
                key: const Key('searchArticleTextField'),
                decoration: InputDecoration(
                  hintText: 'Search articles here..',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              ElevatedButton(
                key: const Key('searchArticleBtn'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ArticlesWidget(category: 'search', keyword: searchTextController.text,)),
                    );
                  },
                  child: const Text('Search'),
              )
            ],
          ),
        ),
      )
    );
  }
}
