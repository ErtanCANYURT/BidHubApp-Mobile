import 'package:flutter/material.dart';

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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
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
                } else {
                  return Center(child: Text('No data available.'));
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
