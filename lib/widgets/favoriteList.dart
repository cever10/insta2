import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/scripts.dart';
import 'package:provider/provider.dart';

class favoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    providerVariable provar = Provider.of<providerVariable>(context);

    return Stack(
      children: [
        Opacity(
          opacity: 0.3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
        ),
        Visibility(
          visible: checkNumBiggerHeight(450, context),
          child: Center(
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              180,
                              0,
                              0,
                              0,
                            ),
                          ),
                          Text(
                            '좋아요',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              145,
                              0,
                              0,
                              0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              provar.updatingCurrentFeedUser('');
                            },
                            icon: Icon(Icons.cancel_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 450,
                    height: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    /*
                                    if (widget.id == provar.myid) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) => MyPage()));
                                    } else {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  AnotherUserPage(widget.id)));
                                    }
                                    */
                                  },
                                  child: Stack(
                                    children: [
                                      /*
                                      if (widget.checkimage == true)
                                        Image.file(
                                          widget.profileimage,
                                          width: 50,
                                          height: 50,
                                        ),
                                      */
                                      //if (widget.checkimage == false)
                                      Image.asset(
                                        'images/normal_profile.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                      Image.asset(
                                        'images/frame.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(5)),
                                Text(
                                  //widget.id,
                                  'widget.id',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                /*
                                if (widget.id != provar.myid &&
                                    widget.checkFollow == false)
                                  Text(
                                    '  •',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                if (widget.id != provar.myid &&
                                    widget.checkFollow == false)
                                  TextButton(
                                    onPressed: () async {
                                      await followDB
                                          .writeFile(widget.id + '\n');
                                      await followerDB
                                          .writeFile(provar.myid + '\n');

                                      memberDB.readFileToList().then((value) {
                                        provar.myfollow += 1;

                                        value.replaceRange(
                                            value.indexOf(
                                                    'id: ' + provar.myid) +
                                                4,
                                            value.indexOf(
                                                    'id: ' + provar.myid) +
                                                5,
                                            [
                                              'follow: ' +
                                                  provar.myfollow.toString()
                                            ]);

                                        value.replaceRange(
                                            value.indexOf('id: ' + widget.id) +
                                                5,
                                            value.indexOf('id: ' + widget.id) +
                                                6,
                                            [
                                              'follower: ' +
                                                  (int.parse(value
                                                              .elementAt(value.indexOf(
                                                                      'id: ' +
                                                                          widget
                                                                              .id) +
                                                                  5)
                                                              .replaceAll(
                                                                  RegExp(
                                                                      'follower: '),
                                                                  '')) +
                                                          1)
                                                      .toString()
                                            ]);

                                        memberDB.writeListToFile(value);
                                      });

                                      setState(() {
                                        widget.checkFollow = true;
                                      });
                                    },
                                    child: Text(
                                      '팔로우',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  */
                              ],
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
        ),
      ],
    );
  }
}
