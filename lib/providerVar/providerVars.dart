import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta2/scripts.dart';

class providerVariable extends ChangeNotifier {
  String myname = "";
  String myid = "";
  String mypassword = "";
  String myintroduction = "";
  int myfeedcount = 0;

  File myimage = File('');
  bool checkmyimage = false;

  String temp = "";

  String temp_name = "";
  String temp_id = "";
  String temp_password = "";
  String temp_introduction = "";
  int temp_feedcount = 0;

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

    LocalStorage imgdb = LocalStorage(myid + '/profile.png');
    await imgdb.createDir(myid);
    myimage = await imgdb.get_filePath();
    checkmyimage = await imgdb.checkFile();
  }

  void updating2(File file, bool check) {
    myimage = file;
    checkmyimage = check;
    notifyListeners();
  }

  void updating3(String msg) {
    myintroduction = msg;
  }

  void updating4(int count) {
    myfeedcount = count;
  }

  void temp_updating(String name, String id, String password) {
    temp_name = name;
    temp_id = id;
    temp_password = password;
  }
}
