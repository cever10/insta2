import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/login_new_profile.dart';
import 'package:insta2/screens/login_page.dart';
import 'package:insta2/scripts.dart';
import 'package:provider/provider.dart';

class login_new_profile2 extends StatefulWidget {
  @override
  State<login_new_profile2> createState() => _login_new_profile2State();
}

class _login_new_profile2State extends State<login_new_profile2> {
  bool? checkboxvar1 = false;
  bool? checkboxvar2 = false;
  bool? checkboxvar3 = false;

  LocalStorage memberDB = LocalStorage("members.txt");
  LocalStorage systemDB = LocalStorage("system.txt");

  int temp = 0;

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
              Text(
                '이용 약관에 동의',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              Text(
                'Instagram 2.0은 회원님의 개인 정보를 안전하게 보호합니다.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                '새 계정을 만들려면 모든 약관에 동의하세요.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Padding(padding: EdgeInsets.all(30)),
              Column(
                children: [
                  Row(),
                  Container(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 250,
                          child: Text(
                            '이용약관 2개에 모두 동의',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          value: checkboxvar1,
                          onChanged: (value) {
                            setState(() {
                              checkboxvar1 = value;
                              checkboxvar2 = value;
                              checkboxvar3 = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Container(
                    height: 2,
                    width: 340,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 250,
                          child: Text(
                            '이용 약관(필수)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          value: checkboxvar2,
                          onChanged: (value) {
                            setState(() {
                              checkboxvar2 = value;

                              if (checkboxvar2 == value &&
                                  checkboxvar3 == value) {
                                checkboxvar1 = value;
                              } else {
                                checkboxvar1 = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Container(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 250,
                          child: Text(
                            '데이터 정책(필수)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          value: checkboxvar3,
                          onChanged: (value) {
                            setState(() {
                              checkboxvar3 = value;

                              if (checkboxvar2 == value &&
                                  checkboxvar3 == value) {
                                checkboxvar1 = value;
                              } else {
                                checkboxvar1 = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(30)),
              Container(
                width: 335,
                height: 47,
                color: Colors.black12,
                child: TextButton(
                  onPressed: () async {
                    if (checkboxvar1 == true) {
                      if (checkboxvar2 == true) {
                        if (checkboxvar3 == true) {
                          await memberDB
                              .writeFile('name: ' + provar.temp_name + '\n');
                          await memberDB
                              .writeFile('id: ' + provar.temp_id + '\n');
                          await memberDB.writeFile(
                              'password: ' + provar.temp_password + '\n');
                          await memberDB.writeFile('introduction: ' +
                              provar.temp_introduction +
                              '\n');
                          await memberDB.writeFile('feedcount: ' +
                              provar.temp_feedcount.toString() +
                              '\n');
                          await memberDB.writeFile('follow: 0\n');
                          await memberDB.writeFile('follower: 0\n');
                          await memberDB.writeFile('\n');

                          systemDB.readFileToList().then((value) {
                            temp = int.parse(value
                                .elementAt(0)
                                .replaceAll(RegExp('membercount: '), ''));
                            value.replaceRange(0, 1,
                                ['membercount: ' + (temp + 1).toString()]);
                            systemDB.writeListToFile(value);
                          });

                          showWinToast('아이디 생성 성공', context);
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => login_page()));
                        }
                      }
                    } else {
                      showWinToast('약관에 동의해주세요', context);
                    }
                  },
                  child: Text(
                    '다음',
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => login_new_profile()));
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
