import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/main_home.dart';
import 'package:insta2/scripts.dart';
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
                    width: 400,
                    height: 400,
                  ),
                if (UserDataList[8] == false)
                  Image.asset(
                    'images/normal_profile.png',
                    width: 400,
                    height: 400,
                  ),
                Image.asset(
                  'images/frame.png',
                  width: 400,
                  height: 400,
                ),
              ],
            ),
            Expanded(
              child: Container(
                height: 400,
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
                        _follower('게시글', UserDataList[4]),
                        _follower('팔로잉', UserDataList[5]),
                        _follower('팔로워', UserDataList[6]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          UserDataList[3],
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
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
      List<Widget> UserFeeds = List<Widget>.empty(growable: true);

      UserDataList = await load_Memberdata(widget.Userid);

      for (int i = 0; i < UserDataList[4]; i++) {
        LocalStorage feedImgDB = LocalStorage(
            widget.Userid + '/feed' + i.toString() + '/feedimg.png');

        feedImgDB.get_filePath().then((value) {
          UserFeeds.add(Container(
            child: Image.file(value),
          ));
        });
      }

      return UserFeeds;
    }

    Future<bool> initUserDB() async {
      UserDataList = await load_Memberdata(widget.Userid);
      return true;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          navigatorList(),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: initUserDB(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == true) {
                          return _information(context);
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
        ],
      ),
    );
  }
}
