import 'package:flutter/material.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/widgets/navigatorList.dart';

class main_home extends StatefulWidget {
  @override
  State<main_home> createState() => _main_homeState();
}

class _main_homeState extends State<main_home> {
  List<Widget> MainScrolView = new List<Widget>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    Future<bool> initInstaFeed() async {
      await addInstaFeed(MainScrolView);
      await addInstaFeed(MainScrolView);
      await addInstaFeed(MainScrolView);
      return true;
    }

    return Scaffold(
      body: Row(
        children: [
          Visibility(
              visible: checkNumBiggerWidth(260, context),
              child: navigatorList()),
          Visibility(
            visible: checkNumBiggerWidth(360 + 100 + 460, context),
            child: Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                    future: initInstaFeed(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == true) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            if (MainScrolView.length == index + 2) {
                              addInstaFeed(MainScrolView);
                            }

                            return MainScrolView[index];
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
