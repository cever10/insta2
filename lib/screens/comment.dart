import 'package:flutter/material.dart';
import 'package:insta2/screens/main_home.dart';
import 'package:insta2/widgets/instafeed.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:provider/provider.dart';

double font_size = 25;

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentState();
}

TextEditingController mycomment = TextEditingController();

class _CommentState extends State<Comment> {
  int h_color = 0, h_count = 0;
  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "댓글",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => main_home(),
            ),
          );
        },
        child: Icon(Icons.arrow_back_ios_sharp),
      ),*/

      body: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  if (provar.checkmyimage == true)
                    Image.file(
                      provar.myimage,
                      width: 40,
                      height: 40,
                    ),
                  if (provar.checkmyimage == false)
                    Image.asset(
                      'images/normal_profile.png',
                      width: 40,
                      height: 40,
                    ),
                  Image.asset(
                    'images/frame.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
              Text(
                "ID",
                style: TextStyle(fontSize: font_size, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Text("게시글내용\n", style: TextStyle(fontSize: font_size)),
            ],
          ),
          //줄 추가//길고 얇은 사각형 추가(가로: 길게, 세로: 개얇게)
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          if (provar.checkmyimage == true)
                            Image.file(
                              provar.myimage,
                              width: 40,
                              height: 40,
                            ),
                          if (provar.checkmyimage == false)
                            Image.asset(
                              'images/normal_profile.png',
                              width: 40,
                              height: 40,
                            ),
                          Image.asset(
                            'images/frame.png',
                            width: 40,
                            height: 40,
                          ),
                        ],
                      ),
                      Text(
                        "ID + comment",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "좋아요: " + h_count.toString() + "개",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          h_color += 1;
                          if (h_color % 2 == 1) {
                            onTap:
                            () {
                              icon:
                              Icon(Icons.favorite_outlined, color: Colors.red);
                            };
                            setState(() {
                              h_count += 1;
                            });
                          } else {
                            onTap:
                            () {
                              icon:
                              Icon(Icons.favorite_border);
                            };
                            setState(
                              () {
                                h_count -= 1;
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
