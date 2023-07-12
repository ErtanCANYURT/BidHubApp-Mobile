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
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/account': (context) => AccountPage(),
        '/sell': (context) => SellPage(),
        '/myListings': (context) => MyListingsPage(),
        '/messages': (context) => MessagesPage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BidHub Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Email ve parola değerlerini al ve giriş işlemlerini gerçekleştir
                String email = emailController.text;
                String password = passwordController.text;
                // Giriş işlemleri burada yapılabilir

                // Giriş işlemi başarılı olduğunda anasayfaya yönlendir
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
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
          Container(
            padding: EdgeInsets.all(20.0),
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
        ],
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Mesaj $index'),
                );
              },
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.attach_file),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Mesajınızı girin...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
