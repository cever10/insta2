import 'package:flutter/material.dart';

class Command extends StatefulWidget {
  const Command({super.key});

  @override
  State<Command> createState() => _CommandState();
}

class _CommandState extends State<Command> {
  int h_color = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Row(
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
              //mainAxisAlignment: MainAxisAlignment.end,

              IconButton(
                icon: Icon(Icons.favorite_outline),
                onPressed: () {
                  h_color += 1;
                  if (h_color % 2 == 1) {
                    icon:
                    Icon(Icons.favorite_outlined, color: Colors.red);
                  } else {
                    icon:
                    Icon(Icons.favorite_outlined, color: Colors.white);
                  }
                },
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Column();
        },
        itemCount: 100,
      ),
    );
  }
}
