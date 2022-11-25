import 'package:flutter/material.dart';
import 'package:insta2/providerVar/providerVars.dart';
import 'package:insta2/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => providerVariable())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta 2.0',
      home: login_page(),
    );
  }
}
