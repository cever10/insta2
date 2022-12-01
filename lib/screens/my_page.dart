//본인 프로필

import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/compile_page.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/widgets/navigatorList.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          children: [
            if (provar.checkmyimage == true)
              Image.file(
                provar.myimage,
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
              ),
            if (provar.checkmyimage == false)
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
                    '@' + provar.myid,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _follower('게시글', provar.myfeedcount),
                    _follower('팔로잉', provar.myfollow),
                    _follower('팔로워', provar.myfollower),
                  ],
                ),
              ],
            ),
          ),
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
        itemCount: provar.myfeedcount,
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

  Widget _compilebutton() {
    return Center(
      child: Container(
        width: 1250,
        height: 47,
        color: Colors.black12,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => CompilePage()));
          },
          child: Text(
            '프로필 편집',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    Future<List<Widget>> initGridview() async {
      List<Widget> myFeeds = List<Widget>.empty(growable: true);

      for (int i = 0; i < provar.myfeedcount; i++) {
        LocalStorage feedImgDB =
            LocalStorage(provar.myid + '/feed' + i.toString() + '/feedimg.png');

        feedImgDB.get_filePath().then((value) {
          myFeeds.add(Container(
            child: Image.file(value),
          ));
        });
      }

      return myFeeds;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      /*
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          provar.myid,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) => main_home()));
              },
              icon: Icon(Icons.home),
              color: Colors.black,
            ),
          ),
        ],
      ),
      */
      body: Row(
        children: [
          Visibility(
            visible: checkNumBiggerWidth(243, context),
            child: navigatorList(),
          ),
          Visibility(
            visible: checkNumBiggerWidth(243 + 610, context),
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
                        _information(context),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.all(10)),
                            Text(
                              provar.myintroduction,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        _compilebutton(),
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
    );
  }
}
