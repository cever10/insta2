import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/anotheruser_page.dart';
import 'package:insta2/screens/main_home.dart';
import 'package:provider/provider.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/widgets/navigatorList.dart';

double font_size = 25;
double whiteSize = 150;

class Comment extends StatefulWidget {
  final int feedCount;
  final String userId;
  final String feedContents;

  Comment(this.feedCount, this.userId, this.feedContents);

  @override
  State<Comment> createState() => _CommentState();
}

TextEditingController mycomment = TextEditingController();

class _CommentState extends State<Comment> {
  int h_color = 0, h_count = 0;
  TextEditingController mycomment = TextEditingController();
  int mycomment_count = 10;

  @override
  Widget build(BuildContext context) {
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => main_home(),
            ),
          );
        },
        child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
        backgroundColor: Colors.black38,
      ),

      body: Row(
        children: [
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
                  future: initComments(),
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
                                        Text.rich(
                                          TextSpan(
                                            text: widget.feedContents,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
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
                                      color: Color.fromARGB(255, 235, 235, 235),
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
                                                    Text(
                                                      UserCommentsList[i],
                                                      style: TextStyle(
                                                        fontSize: 14,
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
                    } else {
                      return Container();
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
