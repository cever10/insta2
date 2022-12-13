import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/login_page.dart';
import 'package:insta2/screens/main_home.dart';
import 'package:insta2/screens/my_page.dart';
import 'package:insta2/screens/post_add_page.dart';
import 'package:insta2/screens/search_page.dart';
import 'package:insta2/scripts.dart';
import 'package:provider/provider.dart';

class navigatorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    return Row(
      children: [
        SingleChildScrollView(
          child: Container(
            height:
                550 + checkPositive(MediaQuery.of(context).size.height - 550),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: 240,
                  height: 80,
                  child: SvgPicture.asset(
                    'images/Instagram.svg',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: TextButton(
                    onPressed: () {
                      if (provar.current_page == 'comment') {
                        Navigator.of(context).pop();
                        provar.updatingCurrentPage('');
                      }

                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (builder) => main_home()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          '홈',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: TextButton(
                    onPressed: () {
                      if (provar.current_page == 'comment') {
                        Navigator.of(context).pop();
                        provar.updatingCurrentPage('');
                      }

                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => search_page()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          '검색',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          '알림',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                */
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: TextButton(
                    onPressed: () {
                      if (provar.current_page == 'comment') {
                        Navigator.of(context).pop();
                        provar.updatingCurrentPage('');
                      }

                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => PostAddPage()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.create,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          '만들기',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: TextButton(
                    onPressed: () {
                      if (provar.current_page == 'comment') {
                        Navigator.of(context).pop();
                        provar.updatingCurrentPage('');
                      }

                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (builder) => MyPage()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.supervised_user_circle,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          '프로필',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: TextButton(
                    onPressed: () {
                      if (provar.current_page == 'comment') {
                        Navigator.of(context).pop();
                        provar.updatingCurrentPage('');
                      }

                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => login_page()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.backspace,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          '로그아웃',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 2,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 220, 220, 220),
          ),
        ),
      ],
    );
  }
}
