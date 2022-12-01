import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/login_page.dart';
import 'package:insta2/screens/main_home.dart';
import 'package:insta2/scripts.dart';
import 'package:provider/provider.dart';

class login_gogo extends StatefulWidget {
  @override
  State<login_gogo> createState() => _login_gogoState();
}

class _login_gogoState extends State<login_gogo> {
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();

  LocalStorage memberDB = LocalStorage("members.txt");

  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    return Scaffold(
      body: Visibility(
        visible: checkNumBiggerWidth(400, context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  100,
                  0,
                  100,
                ),
                child: Text(
                  'Instagram',
                  style: TextStyle(
                    fontSize: 64,
                    fontFamily: "Pacifico",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    checkPositive(
                        MediaQuery.of(context).size.width * 0.5 - 200),
                    0,
                    checkPositive(
                        MediaQuery.of(context).size.width * 0.5 - 200),
                    40),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: id,
                  decoration: InputDecoration(
                    labelText: '아이디',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    checkPositive(
                        MediaQuery.of(context).size.width * 0.5 - 200),
                    0,
                    checkPositive(
                        MediaQuery.of(context).size.width * 0.5 - 200),
                    40),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: password,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              Container(
                width: 335,
                height: 47,
                color: Colors.black12,
                child: TextButton(
                  onPressed: () {
                    memberDB.readFileToList().then((value) {
                      if (value.contains('id: ' + id.text.toString()) == true &&
                          value.elementAt(
                                  value.indexOf('id: ' + id.text.toString()) +
                                      1) ==
                              'password: ' + password.text.toString()) {
                        provar.load_mydata(value, id.text);
                        showWinToast('회원정보 일치O', context);
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => main_home()));
                      } else {
                        showWinToast('회원정보 일치X', context);
                      }
                    });
                  },
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              Container(
                width: 335,
                height: 47,
                color: Colors.black12,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => login_page()));
                  },
                  child: Text(
                    '뒤로가기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(50)),
            ],
          ),
        ),
      ),
    );
  }
}
