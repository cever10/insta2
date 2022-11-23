import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/scripts.dart';
import 'package:provider/provider.dart';

class instaFeed extends StatefulWidget {
  final File img;
  final File profileimage;
  final bool checkimage;
  final String id;
  final String name;
  final String contents;
  String favorite;
  final String feednumber;
  bool checkFavoriteUser;
  String comments;

  final String year;
  final String month;
  final String day;
  final String hour;
  final String minute;
  final String second;

  instaFeed(
    this.img,
    this.profileimage,
    this.checkimage,
    this.id,
    this.name,
    this.contents,
    this.favorite,
    this.feednumber,
    this.checkFavoriteUser,
    this.comments,
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
  );

  @override
  State<instaFeed> createState() => _instaFeedState();
}

class _instaFeedState extends State<instaFeed> {
  bool updating = false;

  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    TextEditingController mycomment = TextEditingController();

    LocalStorage feedfavoriteUserDB = LocalStorage(
        widget.id + '/feed' + widget.feednumber + '/favoriteUsers.txt');

    return Row(
      children: [
        Padding(padding: EdgeInsets.all(100)),
        Container(
          width: 460,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Stack(
                        children: [
                          if (widget.checkimage == true)
                            Image.file(
                              widget.profileimage,
                              width: 50,
                              height: 50,
                            ),
                          if (widget.checkimage == false)
                            Image.asset(
                              'images/normal_profile.png',
                              width: 50,
                              height: 50,
                            ),
                          Image.asset(
                            'images/frame.png',
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      widget.id,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '  •',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '팔로우',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Image.file(widget.img),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    if (widget.checkFavoriteUser == false)
                      IconButton(
                        onPressed: () {
                          if (updating == false) {
                            updating == true;

                            LocalStorage feedDataDB = LocalStorage(widget.id +
                                '/feed' +
                                widget.feednumber +
                                '/data.txt');

                            feedDataDB.readFileToList().then((value) async {
                              value.replaceRange(1, 2, [
                                'favorite: ' +
                                    (int.parse(widget.favorite) + 1).toString()
                              ]);
                              await feedDataDB.writeListToFile(value);
                              await feedfavoriteUserDB
                                  .writeFile(provar.myid + '\n');

                              setState(() {
                                widget.favorite =
                                    (int.parse(widget.favorite) + 1).toString();
                              });

                              widget.checkFavoriteUser = true;

                              updating = false;
                            });
                          }
                        },
                        icon: Icon(Icons.favorite_border),
                      ),
                    if (widget.checkFavoriteUser == true)
                      IconButton(
                        onPressed: () {
                          if (updating == false) {
                            LocalStorage feedDataDB = LocalStorage(widget.id +
                                '/feed' +
                                widget.feednumber +
                                '/data.txt');

                            feedDataDB.readFileToList().then((value) async {
                              value.replaceRange(1, 2, [
                                'favorite: ' +
                                    (int.parse(widget.favorite) - 1).toString()
                              ]);
                              await feedDataDB.writeListToFile(value);
                            });

                            feedfavoriteUserDB
                                .readFileToList()
                                .then((value) async {
                              value.removeAt(value.indexOf(provar.myid));
                              await feedfavoriteUserDB.writeListToFile(value);

                              setState(() {
                                widget.favorite =
                                    (int.parse(widget.favorite) - 1).toString();
                              });

                              widget.checkFavoriteUser = false;

                              updating = false;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        ),
                      ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.chat_bubble_outline),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.note_outlined),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '좋아요 ' + widget.favorite + '개',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.name + ' ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.contents + ' ',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: '태그',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '댓글 ' + widget.comments + '개 모두 보기',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.year + '년 ' + widget.month + '월 ' + widget.day + '일 ',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.chat_bubble_outline),
                    ),
                    Expanded(
                      child: TextField(
                        controller: mycomment,
                        decoration: InputDecoration(
                          hintText: '댓글 달기...',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) async {
                          LocalStorage feedCommentDB = LocalStorage(widget.id +
                              '/feed' +
                              widget.feednumber +
                              '/comments.txt');

                          await feedCommentDB.writeFile(
                              provar.myid + ' ' + mycomment.text + '\n');

                          LocalStorage feedDataDB = LocalStorage(widget.id +
                              '/feed' +
                              widget.feednumber +
                              '/data.txt');

                          feedDataDB.readFileToList().then((value) async {
                            value.replaceRange(2, 3, [
                              'comments: ' +
                                  (int.parse(widget.comments) + 1).toString()
                            ]);
                            await feedDataDB.writeListToFile(value);

                            setState(() {
                              widget.comments =
                                  (int.parse(widget.comments) + 1).toString();

                              mycomment.text = '';
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
