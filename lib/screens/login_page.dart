import 'package:flutter/material.dart';
import 'package:insta2/screens/login_gogo.dart';
import 'package:insta2/screens/login_new_profile.dart';
import 'package:insta2/scripts.dart';

class login_page extends StatefulWidget {
  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  LocalStorage memberDB = LocalStorage("members.txt");
  LocalStorage systemDB = LocalStorage("system.txt");

  @override
  Widget build(BuildContext context) {
    memberDB.checkFile().then((value) async {
      if (value == false) {
        await memberDB.writeFile('name: admin\n');
        await memberDB.writeFile('id: admin\n');
        await memberDB.writeFile('password: 1234\n');
        await memberDB.writeFile('introduction: \n');
        await memberDB.writeFile('feedcount: 0\n');
        await memberDB.writeFile('follow: 0\n');
        await memberDB.writeFile('follower: 0\n');
        await memberDB.writeFile('\n');
      }
    });

    systemDB.checkFile().then((value) async {
      if (value == false) {
        await systemDB.writeFile('membercount: 1');
      }
    });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: getNumBiggerHeight(800, context),
              ),
              Positioned(
                top: checkPositive(
                    MediaQuery.of(context).size.height * 0.5 - 800 / 2),
                left: MediaQuery.of(context).size.width * 0.5 - 1072 / 2,
                child: Image.asset(
                  'images/login_img.png',
                ),
              ),
              Positioned(
                top: checkPositive(
                        MediaQuery.of(context).size.height * 0.5 - 800 / 2) +
                    209,
                left: MediaQuery.of(context).size.width * 0.5 + 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => login_gogo()));
                  },
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    minimumSize: Size(335, 47),
                    onSurface: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: checkPositive(
                        MediaQuery.of(context).size.height * 0.5 - 800 / 2) +
                    269,
                left: MediaQuery.of(context).size.width * 0.5 + 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => login_new_profile()));
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    minimumSize: Size(335, 47),
                    onSurface: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
