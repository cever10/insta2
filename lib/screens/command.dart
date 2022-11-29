import 'package:flutter/material.dart';
import 'package:insta2/screens/main_home.dart';
import 'package:insta2/scripts.dart';
import 'package:insta2/lib/widgets/instafeed.dart';

class Command extends StatefulWidget {
  const Command({super.key});

  @override
  State<Command> createState() => _CommandState();
}

TextEditingController mycomment = TextEditingController();

class _CommandState extends State<Command> {
  int h_color = 0, h_count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => main_home(),
            ),
          );
        },
        child: Icon(Icons.arrow_back_ios_sharp),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: mycomment,
                decoration: InputDecoration(
                  hintText: '댓글 달기...',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                textInputAction: TextInputAction.go,
                onSubmitted: (value) async {
                  LocalStorage feedCommentDB = LocalStorage(widget.id +
                      '/feed' +
                      widget.feednumber +
                      '/comments.txt');

                  await feedCommentDB
                      .writeFile(provar.myid + ' ' + mycomment.text + '\n');

                  LocalStorage feedDataDB = LocalStorage(
                      widget.id + '/feed' + widget.feednumber + '/data.txt');

                  feedDataDB.readFileToList().then((value) async {
                    value.replaceRange(2, 3, [
                      'comments: ' + (int.parse(widget.comments) + 1).toString()
                    ]);
                    await feedDataDB.writeListToFile(value);

                    setState(() {
                      widget.comments =
                          (int.parse(widget.comments) + 1).toString();

                      mycomment.text = '';
                    });
                  });
                },
              ),
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      'images/normal_profile.png',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      "ID + 댓글댓글",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "좋아요: " + h_count.toString() + "개",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        h_color += 1;
                        if (h_color % 2 == 1) {
                          onTap:
                          () {
                            icon:
                            Icon(Icons.favorite_outlined, color: Colors.red);
                          };
                          setState(() {
                            h_count += 1;
                          });
                        } else {
                          onTap:
                          () {
                            icon:
                            Icon(Icons.favorite_border);
                          };
                          setState(
                            () {
                              h_count -= 1;
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ); //change ,=>;
        },
        separatorBuilder: (BuildContext context, int index) {
          return Column();
        },
        itemCount: 100,
      ),
    );
  }
}
