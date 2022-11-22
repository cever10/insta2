import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/login_page.dart';
import 'package:insta2/scripts.dart';
import 'package:provider/provider.dart';
import 'package:insta2/screens/login_new_profile2.dart';

class login_new_profile extends StatefulWidget {
  @override
  State<login_new_profile> createState() => _login_new_profileState();
}

class _login_new_profileState extends State<login_new_profile> {
  TextEditingController name = TextEditingController();
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
                  controller: name,
                  decoration: InputDecoration(
                    labelText: '성명',
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
                  controller: id,
                  decoration: InputDecoration(
                    labelText: '아이디',
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
                  controller: password,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
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
              ElevatedButton(
                onPressed: () {
                  if (name.text != "" && id.text != "" && password.text != "") {
                    memberDB.readFileToList().then((value) {
                      if (value.contains('id: ' + id.text.toString()) ==
                          false) {
                        provar.temp_updating(name.text, id.text, password.text);
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => login_new_profile2()));
                      } else {
                        showWinToast('중복되는 아이디입니다', context);
                      }
                    });
                  } else {
                    showWinToast('빈칸을 채워주세요', context);
                  }
                },
                child: Text(
                  '만들기',
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
              Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  minimumSize: Size(335, 47),
                  onSurface: Colors.white,
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
