import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insta2/widgets/instafeed.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

void showWinToast(String msg, context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width - 300,
        0,
        MediaQuery.of(context).size.width * 0.03,
        30,
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      content: Text(
        msg,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey,
          width: 2,
        ),
      ),
    ),
  );
}

double checkPositive(double num) {
  if (num > 0) {
    return num;
  } else {
    return 0;
  }
}

bool checkNumBiggerWidth(double num, context) {
  if (MediaQuery.of(context).size.width > num) {
    return true;
  } else {
    return false;
  }
}

double getNumBiggerWidth(double num, context) {
  if (MediaQuery.of(context).size.width > num) {
    return MediaQuery.of(context).size.width;
  } else {
    return num;
  }
}

double getNumBiggerHeight(double num, context) {
  if (MediaQuery.of(context).size.height > num) {
    return MediaQuery.of(context).size.height;
  } else {
    return num;
  }
}

Future<List<Widget>> addInstaFeed(List<Widget> wlist, String myid) async {
  LocalStorage memberDB = LocalStorage("members.txt");
  List<String> memberList = List<String>.empty(growable: true);
  List<String> memberNameList = List<String>.empty(growable: true);
  List<int> memberFeedCountList = List<int>.empty(growable: true);

  int tempdata = 0;
  int tempindex = 0;
  String tempname = '';
  String tempid = '';
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

  tempindex = Random().nextInt(memberList.length);
  tempname = memberNameList.elementAt(tempindex);
  tempid = memberList.elementAt(tempindex);
  tempdata = Random().nextInt(memberFeedCountList.elementAt(tempindex));

  LocalStorage feedImgDB =
      LocalStorage(tempid + '/feed' + tempdata.toString() + '/feedimg.png');

  tempimg = await feedImgDB.get_filePath();

  LocalStorage imgdb = LocalStorage(tempid + '/profile.png');

  await imgdb.createDir(tempid);
  tempprofileimg = await imgdb.get_filePath();
  tempcheckimg = await imgdb.checkFile();

  LocalStorage feedDataDB =
      LocalStorage(tempid + '/feed' + tempdata.toString() + '/data.txt');

  templist = await feedDataDB.readFileToList();
  tempcontents = templist.elementAt(0).replaceAll(RegExp('contents: '), '');
  tempfavorite = templist.elementAt(1).replaceAll(RegExp('favorite: '), '');
  tempcomments = templist.elementAt(2).replaceAll(RegExp('comments: '), '');
  tempyear = templist.elementAt(3).replaceAll(RegExp('year: '), '');
  tempmonth = templist.elementAt(4).replaceAll(RegExp('month: '), '');
  tempday = templist.elementAt(5).replaceAll(RegExp('day: '), '');
  temphour = templist.elementAt(6).replaceAll(RegExp('hour: '), '');
  tempminute = templist.elementAt(7).replaceAll(RegExp('minute: '), '');
  tempsecond = templist.elementAt(8).replaceAll(RegExp('second: '), '');

  LocalStorage feedfavoriteUserDB = LocalStorage(
      tempid + '/feed' + tempdata.toString() + '/favoriteUsers.txt');

  templist = await feedfavoriteUserDB.readFileToList();
  checkFavoriteUser = templist.contains(myid);

  LocalStorage followDB = LocalStorage(myid + '/follow.txt');

  templist = await followDB.readFileToList();

  if (templist.contains(tempid) == true) {
    checkFollow = true;
  }

  wlist.add(Padding(padding: EdgeInsets.all(50)));
  wlist.add(instaFeed(
      tempimg,
      tempprofileimg,
      tempcheckimg,
      tempid,
      tempname,
      tempcontents,
      tempfavorite,
      tempdata.toString(),
      checkFavoriteUser,
      tempcomments,
      checkFollow,
      tempyear,
      tempmonth,
      tempday,
      temphour,
      tempminute,
      tempsecond));

  return wlist;
}

class LocalStorage {
  final fileName;

  List<String> pathlist = List<String>.empty(growable: true);

  PathProviderWindows provider = PathProviderWindows();

  LocalStorage(this.fileName);

  Future<File> get _localFile async {
    String? path2 = await provider.getApplicationDocumentsPath();
    String path = '$path2' + '/Insta2 DB';

    await Directory(path).create();
    return File('$path/$fileName');
  }

  Future<void> createDir(String dir) async {
    String? path2 = await provider.getApplicationDocumentsPath();
    String path = '$path2' + '/Insta2 DB';
    await Directory(path + '/' + dir).create();
  }

  Future<void> createDir2(String dir) async {
    String? path2 = await provider.getApplicationDocumentsPath();
    String path = '$path2' + '/Insta2 DB';
    await Directory(path + '/' + dir).create();
  }

  Future<File> get_filePath() async {
    String? path2 = await provider.getApplicationDocumentsPath();
    String path = '$path2' + '/Insta2 DB';
    return File('$path/$fileName');
  }

  Future<bool> checkFile() async {
    File file = await _localFile;
    return file.exists();
  }

  Future<void> writeFile(String msg) async {
    final file = await _localFile;
    await file.writeAsString(msg, mode: FileMode.append);
  }

  Future<void> writeListToFile(List<String> list) async {
    final file = await _localFile;
    await file.writeAsString('');
    for (String str in list) {
      await file.writeAsString(str + '\n', mode: FileMode.append);
    }
  }

  Future<void> writeImageFile(File img) async {
    final file = await _localFile;
    img.copy(file.path);
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<String>> readFileToList() async {
    final file = await _localFile;

    List<String> list = List<String>.empty(growable: true);
    return await file.readAsLines();
  }
}
