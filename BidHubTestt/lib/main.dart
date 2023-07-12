import 'package:flutter/material.dart';
import 'package:bidhubtestt/homepage.dart';
import 'package:bidhubtestt/messages.dart';
import 'package:bidhubtestt/loginpage.dart';
import 'package:bidhubtestt/notfoundpage.dart';

void main() => runApp(BidHubApp());

class BidHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BidHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loginpage',
      routes: {
        '/loginpage': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/messages': (context) => MessagesPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => NotFoundPage());
      },
    );
  }
}
