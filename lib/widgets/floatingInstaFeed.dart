import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/widgets/instafeed.dart';
import 'package:provider/provider.dart';

class floatingInstaFeed extends StatelessWidget {
  final int feedCount;
  final String UserId;

  floatingInstaFeed(this.feedCount, this.UserId);

  int tempdata = 0;
  int tempindex = 0;
  String tempid = '';
  String tempname = '';
  String tempcontents = '';
  String tempfavorite = '';
  String tempcomments = '';
  String tempyear = '';
  String tempmonth = '';
  String tempday = '';
  String temphour = '';
  String tempminute = '';
  String tempsecond = '';
  File tempimg = File('');
  File tempprofileimg = File('');
  Directory tempdir = Directory('');
  bool tempcheckimg = false;
  bool checkFavoriteUser = false;
  bool checkFollow = false;
  List<String> templist = new List<String>.empty(growable: true);
  List<dynamic> templist2 = new List<String>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);
    List<String> fallowerList = List<String>.empty(growable: true);

    List<List<dynamic>> UserDataList =
        List<List<dynamic>>.empty(growable: true);

    AsyncMemoizer amemoizer = AsyncMemoizer();

    Future<dynamic> initFeedData() async {
      return amemoizer.runOnce(() async {
        LocalStorage memberDB = LocalStorage("members.txt");
        List<String> memberList = List<String>.empty(growable: true);
        List<String> memberNameList = List<String>.empty(growable: true);
        List<int> memberFeedCountList = List<int>.empty(growable: true);

        templist = await memberDB.readFileToList();

        for (String str in templist) {
          if (str.contains('id: ') == true) {
            if (int.parse(templist
                    .elementAt(templist.indexOf(str) + 3)
                    .replaceAll(RegExp('feedcount: '), '')) >
                0) {
              memberList.add(str.replaceAll('id: ', ''));

              memberFeedCountList.add(int.parse(templist
                  .elementAt(templist.indexOf(str) + 3)
                  .replaceAll(RegExp('feedcount: '), '')));

              memberNameList.add(templist
                  .elementAt(templist.indexOf(str) - 1)
                  .replaceAll(RegExp('name: '), ''));
            }
          }
        }

        templist2 = await load_Memberdata(UserId);
        tempid = UserId;
        tempname = templist2[0];
        tempdata = feedCount;

        LocalStorage feedImgDB = LocalStorage(
            tempid + '/feed' + tempdata.toString() + '/feedimg.png');

        tempimg = await feedImgDB.get_filePath();

        LocalStorage imgdb = LocalStorage(tempid + '/profile.png');

        await imgdb.createDir(tempid);
        tempprofileimg = await imgdb.get_filePath();
        tempcheckimg = await imgdb.checkFile();

        LocalStorage feedDataDB =
            LocalStorage(tempid + '/feed' + tempdata.toString() + '/data.txt');

        templist = await feedDataDB.readFileToList();
        tempcontents =
            templist.elementAt(0).replaceAll(RegExp('contents: '), '');
        tempfavorite =
            templist.elementAt(1).replaceAll(RegExp('favorite: '), '');
        tempcomments =
            templist.elementAt(2).replaceAll(RegExp('comments: '), '');
        tempyear = templist.elementAt(3).replaceAll(RegExp('year: '), '');
        tempmonth = templist.elementAt(4).replaceAll(RegExp('month: '), '');
        tempday = templist.elementAt(5).replaceAll(RegExp('day: '), '');
        temphour = templist.elementAt(6).replaceAll(RegExp('hour: '), '');
        tempminute = templist.elementAt(7).replaceAll(RegExp('minute: '), '');
        tempsecond = templist.elementAt(8).replaceAll(RegExp('second: '), '');

        LocalStorage feedfavoriteUserDB = LocalStorage(
            tempid + '/feed' + tempdata.toString() + '/favoriteUsers.txt');

        templist = await feedfavoriteUserDB.readFileToList();
        checkFavoriteUser = templist.contains(provar.myid);

        LocalStorage followDB = LocalStorage(provar.myid + '/follow.txt');

        templist = await followDB.readFileToList();

        if (templist.contains(tempid) == true) {
          checkFollow = true;
        }

        return true;
      });
    }

    return FutureBuilder(
      future: initFeedData(),
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
                visible: checkNumBiggerWidth(460, context),
                child: Center(
                  child: SingleChildScrollView(
                    child: instaFeed(
                      tempimg,
                      tempprofileimg,
                      tempcheckimg,
                      tempid,
                      tempname,
                      tempcontents,
                      tempfavorite,
                      feedCount.toString(),
                      checkFavoriteUser,
                      tempcomments,
                      checkFollow,
                      tempyear,
                      tempmonth,
                      tempday,
                      temphour,
                      tempminute,
                      tempsecond,
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
