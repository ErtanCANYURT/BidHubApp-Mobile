import 'package:flutter/material.dart';
import 'package:bidhubtestt/sendmessage.dart';
import 'package:bidhubtestt/sellerpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuctionDetailPage extends StatefulWidget {
  final String auctionId;
  final String auctionName;

  AuctionDetailPage({required this.auctionId, required this.auctionName});

  @override
  _AuctionDetailPageState createState() => _AuctionDetailPageState();
}

class _AuctionDetailPageState extends State<AuctionDetailPage> {
  late Future<Map<String, dynamic>> auctionData;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    auctionData = fetchAuctionData();
  }

  Future<Map<String, dynamic>> fetchAuctionData() async {
    final response = await http.get(Uri.parse('https://bidhubappprod.azurewebsites.net/auction/Auction/GetMyAuction?auctionId=${widget.auctionId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to fetch auction data. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch auction data');
    }
  }

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
      body: FutureBuilder<Map<String, dynamic>>(
        future: auctionData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final auction = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/product_$index.jpg'),
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
                        Text(widget.auctionName),
                        SizedBox(height: 16),
                        Text(
                          'Açıklama',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(auction['description']),
                        SizedBox(height: 16),
                        Text(
                          'Şimdi Al Fiyatı',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(auction['buyNowPrice'].toString()),
                        SizedBox(height: 16),
                        Text(
                          'Başlangıç Fiyatı',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(auction['startingPrice'].toString()),
                        SizedBox(height: 16),
                        Text(
                          'En Yüksek Teklif',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(auction['endingPrice'].toString()),
                        SizedBox(height: 16),
                        Text(
                          'Minimum Teklif Miktarı',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(auction['minBidAmour'].toString()),
                        SizedBox(height: 16),
                        Text(
                          'Açık Artırma Başlangıç Tarihi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(auction['startDate']),
                        SizedBox(height: 16),
                        Text(
                          'Açık Artırma Bitiş Tarihi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(auction['endDate']),
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
                                    builder: (context) => SellerPage(
                                      sellerName: 'Satıcının kullanıcı adı',
                                      sellerLocation: 'Satıcının konumu',
                                    ),
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
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

class MyListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Açık Artırmalarım'),
      ),
      body: ListView.builder(
        itemCount: 5, // Örnek olarak 5 açık artırma listeleniyor
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Açık artırma $index'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuctionDetailPage(
                    auctionId: ' $index',
                    auctionName: 'Açık artırma $index',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
