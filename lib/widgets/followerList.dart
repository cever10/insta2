import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/anotheruser_page.dart';
import 'package:insta2/scripts.dart';
import 'package:provider/provider.dart';

class followerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    List<String> fallowerList = List<String>.empty(growable: true);

    List<List<dynamic>> UserDataList =
        List<List<dynamic>>.empty(growable: true);

    Future<bool> favoriteList() async {
      LocalStorage followUserDB =
          LocalStorage(provar.current_profile_user + '/follower.txt');
      fallowerList = await followUserDB.readFileToList();

      for (int i = 0; i < fallowerList.length; i++) {
        UserDataList.add(await load_Memberdata(fallowerList[i]));
      }

      return true;
    }

    return FutureBuilder(
      future: favoriteList(),
      builder: (context, snapshot) {
        if (snapshot.hasData == true) {
          return Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
              Visibility(
                visible: checkNumBiggerWidth(450, context),
                child: Visibility(
                  visible: checkNumBiggerHeight(450, context),
                  child: Center(
                    child: Container(
                      width: 450,
                      height: 450,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      180,
                                      0,
                                      0,
                                      0,
                                    ),
                                  ),
                                  Text(
                                    '팔로워',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      145,
                                      0,
                                      0,
                                      0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      provar.updatingCurrentProfileUser('');
                                    },
                                    icon: Icon(Icons.cancel_outlined),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 450,
                            height: 400,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              provar.updatingCurrentProfileUser(
                                                  '');
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          AnotherUserPage(
                                                              UserDataList[i]
                                                                  [1])));
                                            },
                                            child: Stack(
                                              children: [
                                                if (UserDataList[i][8] == true)
                                                  Image.file(
                                                    UserDataList[i][7],
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                if (UserDataList[i][8] == false)
                                                  Image.asset(
                                                    'images/normal_profile.png',
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                SvgPicture.asset(
                                                  'images/frame.svg',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.all(5)),
                                          Column(
                                            children: [
                                              Text(
                                                UserDataList[i][1],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                UserDataList[i][0],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
