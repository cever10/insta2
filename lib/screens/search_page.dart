//검색 페이지 ( search_page.dart )

import 'package:flutter/material.dart';
import 'package:insta2/widgets/navigatorList.dart';

class search_page extends StatefulWidget {
  const search_page({super.key});

  @override
  State<search_page> createState() => _searchState();
}

class _searchState extends State<search_page> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _searchState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Widget _searchHistory() {
    return ListView(
      children: List.generate(
          10,
          (index) => ListTile(
                leading: Image.asset(
                  'images/normal_profile.png',
                  width: 50,
                  height: 50,
                ),
                title: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("이전 검색기록 $index"),
                ),
              )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          navigatorList(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 800,
                height: 50,
                child: TextField(
                  //focusNode: focusNode,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  //autofocus: true,
                  controller: _filter,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: "검색어를 입력하세요.",

                    //검색 아이콘
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                      size: 20,
                    ),

                    //검색에서 x 누르면 클리어
                    /*
                    suffixIcon: focusNode.hasFocus
                        ? IconButton(
                            icon: Icon(
                              Icons.cancel,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _filter.clear();
                                _searchText = "";
                              });
                            },
                          )
                        : Container(),
                        */
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
