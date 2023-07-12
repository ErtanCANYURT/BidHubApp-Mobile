import 'package:flutter/material.dart';
import 'package:bidhubtestt/main.dart';

class MyListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorilerim'),
        ),
        body: ListView.builder(
          itemCount: 5, // Favorilere alınmış açık artırma sayısı
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Açık artırma $index'),
              leading: Image.asset(
                'assets/images/auction_$index.jpg', // Değiştirilmesi gereken yol
                width: 50,
                height: 50,
              ),
            );
          },
        ),
      ),
    );
  }
}
