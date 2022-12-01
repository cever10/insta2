//게시글 추가 페이지

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/main_home.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/widgets/navigatorList.dart';
import 'package:provider/provider.dart';

class PostAddPage extends StatefulWidget {
  const PostAddPage({super.key});

  @override
  State<PostAddPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PostAddPage> {
  TextEditingController contents = TextEditingController();

  File _pickedImage = File('');

  Future<void> _pickImage() async {
    final ImagePickerWindows _picker = ImagePickerWindows();
    PickedFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var selected = File(image.path);
      setState(() {
        _pickedImage = selected;
      });
    }
  }

  Widget _profileinfo() {
    return Stack(
      children: [
        if (_pickedImage.path == '')
          Image.asset(
            'images/post_picture.png',
            width: 400,
            height: 400,
          ),
        if (_pickedImage.path != '')
          Image.file(
            _pickedImage,
            width: 400,
            height: 400,
          ),
      ],
    );
  }

  Widget _postinfo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text('내용', style: TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3,
              0, MediaQuery.of(context).size.width * 0.3, 40),
          child: TextField(
            cursorColor: Colors.black,
            controller: contents,
            decoration: InputDecoration(
              labelText: '내용을 입력하세요.',
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addpicturebutton(BuildContext context) {
    return Container(
      width: 550,
      height: 47,
      color: Colors.black12,
      child: TextButton(
        onPressed: () {
          _pickImage();
        },
        child: Text(
          '사진 업로드',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _addpostbutton(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    LocalStorage memberDB = LocalStorage("members.txt");
    LocalStorage feedImgDB = LocalStorage(
        provar.myid + '/feed' + provar.myfeedcount.toString() + '/feedimg.png');
    LocalStorage feedDataDB = LocalStorage(
        provar.myid + '/feed' + provar.myfeedcount.toString() + '/data.txt');
    LocalStorage feedfavoriteUserDB = LocalStorage(provar.myid +
        '/feed' +
        provar.myfeedcount.toString() +
        '/favoriteUsers.txt');

    return Container(
      width: 550,
      height: 47,
      color: Colors.black12,
      child: TextButton(
        onPressed: () {
          if (_pickedImage.path != '') {
            memberDB.readFileToList().then((value) async {
              await feedImgDB.createDir(provar.myid);
              await feedImgDB.createDir2(
                  provar.myid + '/feed' + provar.myfeedcount.toString());
              await feedImgDB.writeImageFile(_pickedImage);

              value.replaceRange(
                  value.indexOf('id: ' + provar.myid) + 3,
                  value.indexOf('id: ' + provar.myid) + 4,
                  ['feedcount: ' + (provar.myfeedcount + 1).toString()]);
              await memberDB.writeListToFile(value);
              provar.myfeedcount += 1;

              await feedDataDB.writeFile('contents: ' + contents.text + '\n');
              await feedDataDB.writeFile('favorite: 0\n');
              await feedDataDB.writeFile('comments: 0\n');
              await feedDataDB
                  .writeFile('year: ' + DateTime.now().year.toString() + '\n');
              await feedDataDB.writeFile(
                  'month: ' + DateTime.now().month.toString() + '\n');
              await feedDataDB
                  .writeFile('day: ' + DateTime.now().day.toString() + '\n');
              await feedDataDB
                  .writeFile('hour: ' + DateTime.now().hour.toString() + '\n');
              await feedDataDB.writeFile(
                  'minute: ' + DateTime.now().minute.toString() + '\n');
              await feedDataDB.writeFile(
                  'second: ' + DateTime.now().second.toString() + '\n');

              await feedfavoriteUserDB.writeFile('');

              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (builder) => main_home()));
            });
          } else {
            showWinToast('이미지를 넣어주세요', context);
          }
        },
        child: Text(
          '게시글 업로드',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '게시글 업로드',
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
                    _profileinfo(),
                    _addpicturebutton(context),
                    _postinfo(),
                    _addpostbutton(context),
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
