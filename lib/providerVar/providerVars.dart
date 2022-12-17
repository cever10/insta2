//프로바이더
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta2/scripts.dart';

class providerVariable extends ChangeNotifier {
  String myname = "";
  String myid = "";
  String mypassword = "";
  String myintroduction = "";
  int myfeedcount = 0;
  int myfollow = 0;
  int myfollower = 0;

  File myimage = File('');
  bool checkmyimage = false;

  String temp = "";

  String temp_name = "";
  String temp_id = "";
  String temp_password = "";
  String temp_introduction = "";
  int temp_feedcount = 0;

  String current_feed_user = '';
  String current_feed_number = '';
  String current_profile_user = '';
  String current_page = '';

  void load_mydata(List<String> list, String id) async {
    myname = list
        .elementAt(list.indexOf('id: ' + id) - 1)
        .replaceAll(RegExp('name: '), '');
    myid = list
        .elementAt(list.indexOf('id: ' + id) + 0)
        .replaceAll(RegExp('id: '), '');
    mypassword = list
        .elementAt(list.indexOf('id: ' + id) + 1)
        .replaceAll(RegExp('password: '), '');
    myintroduction = list
        .elementAt(list.indexOf('id: ' + id) + 2)
        .replaceAll(RegExp('introduction: '), '');
    myfeedcount = int.parse(list
        .elementAt(list.indexOf('id: ' + id) + 3)
        .replaceAll(RegExp('feedcount: '), ''));
    myfollow = int.parse(list
        .elementAt(list.indexOf('id: ' + id) + 4)
        .replaceAll(RegExp('follow: '), ''));
    myfollower = int.parse(list
        .elementAt(list.indexOf('id: ' + id) + 5)
        .replaceAll(RegExp('follower: '), ''));

    LocalStorage imgdb = LocalStorage(myid + '/profile.png');
    await imgdb.createDir(myid);
    myimage = await imgdb.get_filePath();
    checkmyimage = await imgdb.checkFile();

    LocalStorage followDB = LocalStorage(myid + '/follow.txt');

    if (await followDB.checkFile() == false) {
      await followDB.writeFile('');
    }

    LocalStorage followerDB = LocalStorage(myid + '/follower.txt');

    if (await followerDB.checkFile() == false) {
      await followerDB.writeFile('');
    }
  }

  void updatingProfile(File file, bool check) {
    myimage = file;
    checkmyimage = check;
    notifyListeners();
  }

  void updatingCurrentFeedUser(String value, String value2) {
    current_feed_user = value;
    current_feed_number = value2;
    notifyListeners();
  }

  void updatingCurrentProfileUser(String value) {
    current_profile_user = value;
    notifyListeners();
  }

  void updatingCurrentPage(String value) {
    current_page = value;
    notifyListeners();
  }
}
