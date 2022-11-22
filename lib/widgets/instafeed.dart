import 'dart:io';

import 'package:flutter/material.dart';

class instaFeed extends StatelessWidget {
  final File img;
  final File profileimage;
  final bool checkimage;
  final String id;
  final String name;

  instaFeed(this.img, this.profileimage, this.checkimage, this.id, this.name);

  @override
  Widget build(BuildContext context) {
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
                          if (checkimage == true)
                            Image.file(
                              profileimage,
                              width: 50,
                              height: 50,
                            ),
                          if (checkimage == false)
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
                      id,
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
                child: Image.file(img),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
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
                  '좋아요 0개',
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
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '내용',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '태그',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '댓글 0개',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '11월 10일',
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
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.chat_bubble_outline),
                    ),
                    Text(
                      '댓글 달기...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
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
