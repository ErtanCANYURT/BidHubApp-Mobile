import 'package:flutter/material.dart';
import 'package:bidhubtestt/main.dart';
import 'package:bidhubtestt/auctiondetail.dart'; // AuctionDetailPage import edildi

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
            return Card(
              child: InkWell(
                onTap: () {
                  // Favori ilanın detay sayfasına yönlendirme
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuctionDetailPage(auctionName: 'Açık artırma $index'), // Güncellenen kısım
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/auction_$index.jpg'), // Değiştirilmesi gereken yol
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Açık artırma $index',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Açıklama',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red, // Favori butonunun rengi kırmızı
                      ),
                      onPressed: () {
                        // Favoriden çıkarma işlemi
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
