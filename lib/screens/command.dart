import 'package:flutter/material.dart';

class Command extends StatefulWidget {
  const Command({super.key});

  @override
  State<Command> createState() => _CommandState();
}

class _CommandState extends State<Command> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Image.asset(
              'images/Biyu.png',
              width: 30,
              height: 30,
            ),
            Text(
              "@ddd_uk87",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            Text(
              "댓글댓글",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Column();
      },
      itemCount: 100,
    ));
  }
}
