import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:provider/provider.dart';

double font_size = 25;
double whiteSize = 150;
class Comment extends StatefulWidget {
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

      body: Row(
        children: [
          Container(
            height: whiteSize,
            width: whiteSize,
            color: Colors.white,
          ),
          Column(
            children: [
              //게시글의 사진+id+게시글 내용
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
                  Text("게시글내용\n집가고 싶다", style: TextStyle(fontSize: font_size)),
                ],
              ),
              //게시글/댓글 구분선 추가 보류
              /*
              Container(
                height: 1,
                width: 1920,
                color: Colors.grey,
              ),
              */
              //댓글
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            //댓글 프로필 이미지를 Stack으로 구현
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
                            //댓글 프로필 아이디와 실제 댓글 구현/중간에 padding추가
                            Text(
                              "ID",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                            Padding(padding: EdgeInsets.all(15)),
                            Text(
                              "comment",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            //댓글 좋아요 갯수 Text로 구현
                            Text(
                              "좋아요: " + h_count.toString() + "개",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            //♡(빈 하트) IconButton 구현 시도, onPress() 시 변환 아직 불가
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {
                                h_color += 1;
                                if (h_color % 2 == 1) {
                                  onTap:
                                  () {
                                    icon:
                                    Icon(Icons.favorite_outlined,
                                        color: Colors.red);
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
                ],
              ),
            ],
          ),
          Container(
            height: whiteSize,
            width: whiteSize,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
