import 'package:flutter/material.dart';
import 'package:bidhubtestt/messages.dart';
import 'package:bidhubtestt/homepage.dart';
import 'package:bidhubtestt/loginpage.dart';
import 'package:bidhubtestt/notfoundpage.dart';
import 'package:bidhubtestt/account.dart';
import 'package:bidhubtestt/sell.dart';
import 'package:bidhubtestt/mylisting.dart';

void main() => runApp(BidHubApp());

class MainTemplate extends StatefulWidget {
  final Widget child;

  MainTemplate({required this.child});

  @override
  _MainTemplateState createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SellPage(),
    MyListingPage(),
    MessagesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BidHub'),
      ),
      body: widget.child,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.red, // Menü arka plan rengi olarak kırmızı
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: 'Sell',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'My Listings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/account');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/sell');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/myListings');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/messages');
            }
          },
        ),
      ),
    );
  }
}

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
        '/account': (context)=> AccountPage(),
        '/sell' : (context)=> SellPage(),
        '/myListings': (context)=> MyListingPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => NotFoundPage());
      },
    );
  }
}