import 'package:flutter/material.dart';
import 'package:insta2/screens/main_home.dart';

class Command extends StatefulWidget {
  const Command({super.key});

  @override
  State<Command> createState() => _CommandState();
}
TextEditingController mycommend = TextEditingController();

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
                controller: mycommend
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
