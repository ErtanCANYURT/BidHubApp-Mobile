import 'package:flutter/material.dart';

void main() => runApp(BidHubApp());

class BidHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BidHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/account': (context) => AccountPage(),
        '/sell': (context) => SellPage(),
        '/myListings': (context) => MyListingsPage(),
        '/messages': (context) => MessagesPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BidHub'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<String>>(
              future: fetchNewAuctions(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index]),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/account');
              },
              icon: Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sell');
              },
              icon: Icon(Icons.add_shopping_cart),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/myListings');
              },
              icon: Icon(Icons.list),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/messages');
              },
              icon: Icon(Icons.message),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> fetchNewAuctions() async {
    await Future.delayed(Duration(seconds: 2));
    return ['Açık artırma 1', 'Açık artırma 2', 'Açık artırma 3', 'Açık artırma 4', 'Açık artırma 5', 'Açık artırma 6'];
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesabım'),
      ),
      body: Center(
        child: Text('Hesabım sayfası'),
      ),
    );
  }
}

class SellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sat'),
      ),
      body: Center(
        child: Text('Satış sayfası'),
      ),
    );
  }
}

class MyListingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlanlarım'),
      ),
      body: Center(
        child: Text('İlanlarım sayfası'),
      ),
    );
  }
}

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesajlarım'),
      ),
      body: Center(
        child: Text('Mesajlarım sayfası'),
      ),
    );
  }
}
