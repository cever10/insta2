import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/widgets/floatingInstaFeed.dart';
import 'package:insta2/widgets/followerList.dart';
import 'package:insta2/widgets/followingList.dart';
import 'package:insta2/widgets/navigatorList.dart';
import 'package:provider/provider.dart';

class AnotherUserPage extends StatefulWidget {
  final String Userid;

  AnotherUserPage(this.Userid);

  @override
  State<AnotherUserPage> createState() => _AnotherUserPageState();
}

class _AnotherUserPageState extends State<AnotherUserPage> {
  List<dynamic> UserDataList = List<dynamic>.empty(growable: true);

  bool checkFollow = false;

  int checkState = 0;
  int current_feed_count = 0;

  Widget _followbutton(BuildContext context, bool checkFollow) {
    providerVariable provar = Provider.of<providerVariable>(context);

    return Column(
      children: [
        if (checkFollow == false)
          Center(
            child: Container(
              width: 1250,
              height: 47,
              color: Colors.black12,
              child: TextButton(
                onPressed: () async {
                  LocalStorage memberDB = LocalStorage('members.txt');
                  LocalStorage followDB =
                      LocalStorage(provar.myid + '/follow.txt');
                  LocalStorage followerDB =
                      LocalStorage(widget.Userid + '/follower.txt');

                  List<String> templist = List<String>.empty(growable: true);

                  await followDB.writeFile(widget.Userid + '\n');
                  await followerDB.writeFile(provar.myid + '\n');

                  templist = await memberDB.readFileToList();
                  provar.myfollow += 1;

                  templist.replaceRange(
                      templist.indexOf('id: ' + provar.myid) + 4,
                      templist.indexOf('id: ' + provar.myid) + 5,
                      ['follow: ' + provar.myfollow.toString()]);

                  templist.replaceRange(
                      templist.indexOf('id: ' + widget.Userid) + 5,
                      templist.indexOf('id: ' + widget.Userid) + 6, [
                    'follower: ' +
                        (int.parse(templist
                                    .elementAt(templist
                                            .indexOf('id: ' + widget.Userid) +
                                        5)
                                    .replaceAll(RegExp('follower: '), '')) +
                                1)
                            .toString()
                  ]);

                  await memberDB.writeListToFile(templist);

                  setState(() {
                    checkFollow = true;
                  });
                },
                child: Text(
                  '?????????',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.grey,
                //   minimumSize: Size(MediaQuery.of(context).size.width * 0.83, 48),
                //   onSurface: Colors.white,
                // ),
              ),
            ),
          ),
        if (checkFollow == true)
          Center(
            child: Container(
              width: 1250,
              height: 47,
              color: Colors.black12,
              child: TextButton(
                onPressed: () async {
                  LocalStorage memberDB = LocalStorage('members.txt');
                  LocalStorage followDB =
                      LocalStorage(provar.myid + '/follow.txt');
                  LocalStorage followerDB =
                      LocalStorage(widget.Userid + '/follower.txt');

                  List<String> templist = List<String>.empty(growable: true);

                  templist = await memberDB.readFileToList();

                  provar.myfollow -= 1;

                  templist.replaceRange(
                      templist.indexOf('id: ' + provar.myid) + 4,
                      templist.indexOf('id: ' + provar.myid) + 5,
                      ['follow: ' + provar.myfollow.toString()]);

                  templist.replaceRange(
                      templist.indexOf('id: ' + widget.Userid) + 5,
                      templist.indexOf('id: ' + widget.Userid) + 6, [
                    'follower: ' +
                        (int.parse(templist
                                    .elementAt(templist
                                            .indexOf('id: ' + widget.Userid) +
                                        5)
                                    .replaceAll(RegExp('follower: '), '')) -
                                1)
                            .toString()
                  ]);

                  await memberDB.writeListToFile(templist);

                  templist = await followDB.readFileToList();
                  templist.remove(widget.Userid);
                  await followDB.writeListToFile(templist);

                  templist = await followerDB.readFileToList();
                  templist.remove(provar.myid);
                  await followerDB.writeListToFile(templist);

                  setState(() {
                    checkFollow = false;
                  });
                },
                child: Text(
                  '?????????',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.grey,
                //   minimumSize: Size(MediaQuery.of(context).size.width * 0.83, 48),
                //   onSurface: Colors.white,
                // ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _follower(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 30, color: Colors.black),
        )
      ],
    );
  }

  Widget _information(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                if (UserDataList[8] == true)
                  Image.file(
                    UserDataList[7],
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                if (UserDataList[8] == false)
                  Image.asset(
                    'images/normal_profile.png',
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                Image.asset(
                  'images/frame.png',
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                ),
              ],
            ),
            Expanded(
              child: Container(
                //height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        50,
                        50,
                        0,
                        50,
                      ),
                      child: Text(
                        '@' + UserDataList[1],
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: _follower('?????????', UserDataList[4]),
                        ),
                        TextButton(
                          onPressed: () {
                            provar.updatingCurrentProfileUser(widget.Userid);
                            setState(() {
                              checkState = 1;
                            });
                          },
                          child: _follower('?????????', UserDataList[5]),
                        ),
                        TextButton(
                          onPressed: () {
                            provar.updatingCurrentProfileUser(widget.Userid);
                            setState(() {
                              checkState = 2;
                            });
                          },
                          child: _follower('?????????', UserDataList[6]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Text(
              UserDataList[3],
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _tapview(BuildContext context, List<Widget> myFeeds) {
    providerVariable provar = Provider.of<providerVariable>(context);

    return GridView.builder(
        padding: EdgeInsets.all(15),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: UserDataList[4],
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (BuildContext context, int index) {
          return myFeeds[index];
        });
  }

  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    Future<List<Widget>> initGridview() async {
      List<Widget> myFeeds = List<Widget>.empty(growable: true);

      UserDataList = await load_Memberdata(widget.Userid);

      for (int i = 0; i < UserDataList[4]; i++) {
        LocalStorage feedImgDB = LocalStorage(
            widget.Userid + '/feed' + i.toString() + '/feedimg.png');

        feedImgDB.get_filePath().then((value) {
          myFeeds.add(Container(
            child: TextButton(
              onPressed: () {
                provar.updatingCurrentProfileUser(widget.Userid);

                setState(() {
                  checkState = 3;
                  current_feed_count = i;
                });
              },
              child: Image.file(value),
            ),
          ));
        });
      }

      return myFeeds;
    }

    Future<bool> initUserDB() async {
      UserDataList = await load_Memberdata(widget.Userid);

      LocalStorage followDB = LocalStorage(provar.myid + '/follow.txt');

      List<String> templist = List<String>.empty(growable: true);

      bool checkFollow = false;

      templist = await followDB.readFileToList();
      if (templist.contains(widget.Userid) == true) {
        checkFollow = true;
      }

      return checkFollow;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Row(
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
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                              future: initUserDB(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData == true) {
                                  return Column(
                                    children: [
                                      _information(context),
                                      _followbutton(context, snapshot.data!),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            FutureBuilder(
                              future: initGridview(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData == true) {
                                  return _tapview(context, snapshot.data!);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (provar.current_profile_user != '' && checkState == 1)
            followingList(),
          if (provar.current_profile_user != '' && checkState == 2)
            followerList(),
          if (provar.current_profile_user != '' && checkState == 3)
            floatingInstaFeed(current_feed_count, widget.Userid),
        ],
      ),
    );
  }
}
