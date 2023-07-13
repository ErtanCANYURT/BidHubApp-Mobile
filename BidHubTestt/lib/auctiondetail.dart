import 'package:flutter/material.dart';
import 'package:bidhubtestt/sendmessage.dart';
import 'package:bidhubtestt/sellerpage.dart';

class AuctionDetailPage extends StatefulWidget {
  @override
  _AuctionDetailPageState createState() => _AuctionDetailPageState();
}

class _AuctionDetailPageState extends State<AuctionDetailPage> {
  final List<String> images = [
    'assets/images/product_1.jpg',
    'assets/images/product_2.jpg',
    'assets/images/product_3.jpg',
  ];
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Açık Artırma Detayı'),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'İlan Adı',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Açık artırma adı gelecek'),
                  SizedBox(height: 16),
                  Text(
                    'Açıklama',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Açık artırma açıklaması gelecek'),
                  SizedBox(height: 16),
                  Text(
                    'Şimdi Al Fiyatı',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Şimdi al fiyatı gelecek'),
                  SizedBox(height: 16),
                  Text(
                    'Başlangıç Fiyatı',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('En yüksek teklif gelecek'),
                  SizedBox(height: 16),
                  Text(
                    'En Yüksek Teklif',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Başlangıç fiyatı gelecek'),
                  SizedBox(height: 16),
                  Text(
                    'Minimum Teklif Miktarı',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Minimum teklif miktarı gelecek'),
                  SizedBox(height: 16),
                  Text(
                    'Açık Artırma Başlangıç Tarihi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Açık artırma başlangıç tarihi gelecek'),
                  SizedBox(height: 16),
                  Text(
                    'Açık Artırma Bitiş Tarihi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Açık artırma bitiş tarihi gelecek'),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Teklifiniz',
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Teklifi göndermek için işlemler
                          },
                          child: Text('Teklif Gönder'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Satıcıyla iletişime geçmek için işlemler
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SendMessagePage(message: 'Mesajınızı buraya yazın'),
                              ),
                            );
                          },
                          child: Text('Satıcıyla İletişime Geç'),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Satıcının profil sayfasına yönlendirme işlemleri
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SellerPage(sellerName: 'Satıcının kullanıcı adı', sellerLocation: 'Satıcının konumu'),
                            ),
                          );
                        },
                        child: Text('Satıcı Profili'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  final String username;

  AccountPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı Profili'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kullanıcı Adı: $username',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Kullanıcı profil sayfasından geri dönmek için işlemler
                Navigator.pop(context);
              },
              child: Text('Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }
}
