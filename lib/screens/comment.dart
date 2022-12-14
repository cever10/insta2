import 'dart:io';
//Line 144
import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/anotheruser_page.dart';
import 'package:insta2/screens/main_home.dart';
import 'package:provider/provider.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/widgets/navigatorList.dart';

double font_size = 25;

class Comment extends StatefulWidget {
  final int feedCount;
  final String userId;
  final String feedContents;
  final File UserProfile;
  final bool checkProfile;

  Comment(this.feedCount, this.userId, this.feedContents, this.UserProfile,
      this.checkProfile);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController mycomment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //
    providerVariable provar = Provider.of<providerVariable>(context);

    List<String> commentsOrignList = List<String>.empty(growable: true);
    List<List<dynamic>> UserDataList =
        List<List<dynamic>>.empty(growable: true);
    List<String> UserCommentsList = List<String>.empty(growable: true);

    Future<List<String>> initComments() async {
      LocalStorage feedCommentsDB = LocalStorage(widget.userId +
          '/feed' +
          widget.feedCount.toString() +
          '/comments.txt');

      if (await feedCommentsDB.checkFile() == true) {
        commentsOrignList = await feedCommentsDB.readFileToList();
      }

      for (var str in commentsOrignList) {
        UserDataList.add(await load_Memberdata(str.split(' ')[0]));

        if (commentsOrignList.length > UserCommentsList.length) {
          UserCommentsList.add(
              str.replaceAll(RegExp(str.split(' ')[0] + ' '), ''));
        }
      }

      return UserCommentsList;
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "댓글",
      //     style: TextStyle(fontSize: 30, color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      //   leading: BackButton(color: Colors.black),
      // ),

      //이전페이지로 돌아가게 버튼설정
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
          provar.updatingCurrentPage('');
        },
        child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
        backgroundColor: Colors.black38,
      ),

      body: Row(
        children: [
          //화면 크기를 줄였을때 위젯에서 오버플로우가 남
          //visibility를 사용해 위젯 크기보다 화면이 작아지면 위젯을 안보이게함

          Visibility(
            visible: checkNumBiggerWidth(243, context),
            child: navigatorList(),
          ),
          Visibility(
            visible: checkNumBiggerWidth(243 + 690, context),
            child: Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  //미리 불러오는 기능
                  future: initComments(),
                  //snapshot: 불러온 데이터가 들어가는 저장소
                  builder: (context, snapshot) {
                    if (snapshot.hasData == true) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                          ),
                          //
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //게시글의 사진+id+게시글 내용
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Row(
                                      children: [
                                        //stack으로 프로필구현
                                        Stack(
                                          children: [
                                            if (widget.checkProfile ==
                                                true) ...[
                                              Image.file(
                                                widget.UserProfile,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ] else ...[
                                              Image.asset(
                                                'images/normal_profile.png',
                                                width: 40,
                                                height: 40,
                                              ),
                                            ],
                                            Image.asset(
                                              'images/frame.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ],
                                        ),
                                        //
                                        Padding(padding: EdgeInsets.all(8)),
                                        Text(
                                          widget.userId,
                                          style: TextStyle(
                                              fontSize: font_size,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Column(
                                      children: [
                                        //rich 와 spam을 같이 써야함
                                        //그냥 text만 쓰면 지정된 범위 넘었을때 오버플로우 오류가 남,
                                        //범위 넘어갔을때 자동으로 줄바꿈 해주는 함수
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: widget.feedContents,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //게시글이랑 댓글 구분선
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Container(
                                      width: 1300,
                                      height: 2,
                                      color: Colors.black38,
                                    ),
                                  ),

                                  //댓글 추가 코드
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Container(
                                      width: 1500,
                                      color: Colors.black12,
                                      child: TextField(
                                        controller: mycomment,
                                        decoration: InputDecoration(
                                          hintText: '댓글 달기...',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        textInputAction: TextInputAction.go,
                                        onSubmitted: (value) async {
                                          LocalStorage feedCommentDB =
                                              LocalStorage(widget.userId +
                                                  '/feed' +
                                                  widget.feedCount.toString() +
                                                  '/comments.txt');

                                          await feedCommentDB.writeFile(
                                              provar.myid +
                                                  ' ' +
                                                  mycomment.text +
                                                  '\n');

                                          LocalStorage feedDataDB =
                                              LocalStorage(widget.userId +
                                                  '/feed' +
                                                  widget.feedCount.toString() +
                                                  '/data.txt');

                                          feedDataDB
                                              .readFileToList()
                                              .then((value) async {
                                            value.replaceRange(2, 3, [
                                              'comments: ' +
                                                  (int.parse(value
                                                              .elementAt(
                                                                  value.indexOf(
                                                                      value[2]))
                                                              .replaceAll(
                                                                  RegExp(
                                                                      'comments: '),
                                                                  '')) +
                                                          1)
                                                      .toString()
                                            ]);
                                            await feedDataDB
                                                .writeListToFile(value);

                                            setState(() {
                                              mycomment.text = '';
                                            });
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  //게시글/댓글 구분선 추가 보류
                                  /*
                                        Container(
                                          height: 1,
                                          width: 1920,
                                          color: Colors.grey,
                                        ),
                                        */
                                  /*
                                        댓글 구현 시작
                                        */
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (int i = 0;
                                            i < UserDataList.length;
                                            i++) ...[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    provar
                                                        .updatingCurrentProfileUser(
                                                            '');
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (builder) =>
                                                                AnotherUserPage(
                                                                    UserDataList[
                                                                            i]
                                                                        [1])));
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      if (UserDataList[i][8] ==
                                                          true)
                                                        Image.file(
                                                          UserDataList[i][7],
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      if (UserDataList[i][8] ==
                                                          false)
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
                                                Padding(
                                                    padding: EdgeInsets.all(5)),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      UserDataList[i][1],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              243) *
                                                          0.5,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  UserCommentsList[
                                                                      i],
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    //데이터 받아올 때 까지 대기
                    else {
                      return Container(
                        child: Text(
                          "로딩중...",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
