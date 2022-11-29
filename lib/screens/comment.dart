import 'package:flutter/material.dart';
import 'package:insta2/screens/main_home.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentState();
}

TextEditingController mycomment = TextEditingController();

class _CommentState extends State<Comment> {
  int h_color = 0, h_count = 0, c_count = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "댓글",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => main_home(),
            ),
          );
        },
        child: Icon(Icons.arrow_back_ios_sharp),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      'images/normal_profile.png',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      "ID + 댓글댓글",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "좋아요: " + h_count.toString() + "개",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
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
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Column(); //여기에는 생긴 리스트 칸마다 추가 가능함.
        },
        itemCount: c_count,
      ),
    );
  }
}
