//검색 페이지 ( search_page.dart )

import 'package:flutter/material.dart';
import 'package:insta2/scripts.dart';
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

  Widget _search_history() {
    return Column(
      children: [
        for (int i = 0; i < 10; i++) ...[
          Container(
            height: 3,
            width: 800,
            color: Colors.white,
          ),
          Container(
            height: 50,
            width: 800,
            color: Colors.black12,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "검색기록 $i",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Visibility(
            visible: checkNumBiggerWidth(243, context),
            child: navigatorList(),
          ),
          Visibility(
            visible: checkNumBiggerWidth(243 + 800, context),
            child: Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      child: Column(children: [
                        Image.asset('images/instagram_logo_nemo.png',
                            height: 300),

                        //검색창
                        Container(
                          width: 800,
                          height: 50,
                          child: TextField(
                            cursorColor: Colors.black,
                            focusNode: focusNode,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                            autofocus: true,
                            controller: _filter,
                            decoration: InputDecoration(
                              labelText: '검색',
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),

                              //검색 아이콘
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black54,
                                size: 20,
                              ),

                              //검색에서 x 누르면 클리어
                              suffixIcon: focusNode.hasFocus
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.cancel,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _filter.clear();
                                          focusNode.unfocus();
                                          _searchText = "";
                                        });
                                      },
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                        if (_filter.text != '') ...[
                          _search_history()
                        ] else ...[
                          Container()
                        ],
                        //focusNode.hasFocus ? _search_history() : Container()
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
