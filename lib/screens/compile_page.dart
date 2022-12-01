//프로필 편집 페이지

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/my_page.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/widgets/navigatorList.dart';
import 'package:provider/provider.dart';

class CompilePage extends StatefulWidget {
  @override
  State<CompilePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CompilePage> {
  TextEditingController name = TextEditingController();
  TextEditingController introduction = TextEditingController();

  LocalStorage memberDB = LocalStorage("members.txt");

  Future<void> _pickImage(BuildContext context) async {
    providerVariable provar =
        Provider.of<providerVariable>(context, listen: false);

    // 프로필 저장 기능
    LocalStorage imgdb = LocalStorage(provar.myid + '/profile.png');

    final ImagePickerWindows _picker = ImagePickerWindows();
    PickedFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var selected = File(image.path);
      provar.updatingProfile(selected, true);
      imgdb.createDir(provar.myid);
      imgdb.writeImageFile(selected);
    }
    // 프로필 저장 기능
  }

  Widget _profileinfo(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    return TextButton(
      onPressed: () {
        _pickImage(context);
      },
      child: Stack(
        children: [
          if (provar.checkmyimage == true)
            Image.file(
              provar.myimage,
              width: 400,
              height: 400,
            ),
          if (provar.checkmyimage == false)
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
    );
  }

  Widget _nameinfo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text('이름 변경', style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3,
              0, MediaQuery.of(context).size.width * 0.3, 40),
          child: TextField(
            controller: name,
            decoration: InputDecoration(
              labelText: '이름 변경',
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _IDinfo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text('ID 변경', style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3,
              0, MediaQuery.of(context).size.width * 0.3, 40),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'ID 입력',
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _produceinfo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text('한줄소개 변경', style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3,
              0, MediaQuery.of(context).size.width * 0.3, 40),
          child: TextField(
            controller: introduction,
            decoration: InputDecoration(
              labelText: '한줄소개 입력',
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  /*
  Widget _editbutton(BuildContext context) {
    return Container(
      width: 550,
      height: 47,
      color: Colors.black12,
      child: TextButton(
        onPressed: () {
          _pickImage(context);
        },
        child: Text(
          '프로필 편집',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  */
  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    name.text = provar.myname;
    introduction.text = provar.myintroduction;

    return Scaffold(
      backgroundColor: Colors.white,
      /*
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '프로필 편집',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) => MyPage()));
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
          ),
        ],
      ),
      */
      body: Row(
        children: [
          navigatorList(),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _profileinfo(context),
                    //_editbutton(context),
                    _nameinfo(),
                    //_IDinfo(),
                    _produceinfo(),
                    Container(
                      width: 550,
                      height: 47,
                      color: Colors.black12,
                      child: TextButton(
                        onPressed: () {
                          if (name.text != '') {
                            memberDB.readFileToList().then((value) {
                              value.replaceRange(
                                  value.indexOf('id: ' + provar.myid) + 2,
                                  value.indexOf('id: ' + provar.myid) + 3,
                                  ['introduction: ' + introduction.text]);

                              value.replaceRange(
                                  value.indexOf('id: ' + provar.myid) - 1,
                                  value.indexOf('id: ' + provar.myid) + 0,
                                  ['name: ' + name.text]);
                              memberDB.writeListToFile(value);

                              provar.myname = name.text;
                              provar.myintroduction = introduction.text;

                              showWinToast('프로필이 저장되었습니다', context);

                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => MyPage()));
                            });
                          } else {
                            showWinToast('이름을 채워주세요', context);
                          }
                        },
                        child: Text(
                          '저장',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(50))
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
