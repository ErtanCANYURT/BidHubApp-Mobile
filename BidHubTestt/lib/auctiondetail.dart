import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Utils/constants.dart';
import 'sendmessage.dart';
import 'sellerpage.dart';

class AuctionDetailPage extends StatefulWidget {
  final String auctionId;
  final String auctionName;
  final String sellerId; // Eklenen parametre

  AuctionDetailPage({required this.auctionId, required this.auctionName, required this.sellerId});

  @override
  _AuctionDetailPageState createState() => _AuctionDetailPageState();
}

class _AuctionDetailPageState extends State<AuctionDetailPage> {
  late Future<Map<String, dynamic>> auctionData;
  bool isFavorite = false;
  TextEditingController bidAmountController = TextEditingController();

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

  Future<void> submitBid() async {
    final bidAmount = int.parse(bidAmountController.text);
    final createdDate = DateTime.now().toUtc().toString();

    String url = 'https://bidhubappprod.azurewebsites.net/bids/Bids/AddAsync'; // API'nizin URL'sini buraya yazın
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${Constants.user.userAccessToken}'};
    Map<String, dynamic> jsonBody = {
      'AuctionId': widget.auctionId,
      'BidAmount': bidAmount,
      'CreatedDate': createdDate,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jsonBody),
      );

      if (response.statusCode == 200) {
        // Bid submitted successfully
        // Handle the response if needed
        print('Bid submitted');
      } else {
        // Handle error response
        print('Failed to submit bid. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Failed to submit bid. Error: $e');
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
            onPressed: () async {
              //BURADA MERKEZE POST YAPICAK FAVORİ EKLİYCEK
              String url = 'https://bidhubappprod.azurewebsites.net/favorite/Favorite/AddFavoriteAsync'; // API'nizin URL'sini buraya yazın
              Map<String, String> headers = {'Content-Type': 'application/json'};
              Map<String, dynamic> jsonBody = {
                'UserId' : 10,
                'AuctionId': widget.auctionId,
                'DateTime' : DateTime.now().toUtc().toIso8601String(),
              };

              try {
                http.Response response = await http.post(
                  Uri.parse(url),
                  headers: headers,
                  body: jsonEncode(jsonBody),
                );

                // İstek başarılıysa ve kullanıcı girişi onaylandıysa
                if (response.statusCode == 200) {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                } else {
                  // İstek başarılı olmadıysa veya kullanıcı girişi hatalıysa hata mesajını gösterin
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Hata'),
                        content: Text('Ürün favoriye eklenemedi. Lütfen tekrar deneyin.'),
                        actions: [
                          TextButton(
                            child: Text('Tamam'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              } catch (e) {
                // İstek gönderilirken bir hata oluştuysa hata mesajını gösterin
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Hata'),
                      content: Text('Bir hata oluştu. Lütfen tekrar deneyin.'),
                      actions: [
                        TextButton(
                          child: Text('Tamam'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
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
            if (auction == null) {
              return Center(
                child: Text('No data available'),
              );
            }

            // Get the total number of images
            final totalImages = auction['totalImages'] ?? 0;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: totalImages,
                      itemBuilder: (context, index) {
                        final imagePath = 'assets/images/${widget.auctionId}/${index + 1}.jpg'; // Değişiklik yapıldı
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagePath),
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
                        Text(auction['minBidAmount'].toString()),
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
                          controller: bidAmountController,
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
                                  submitBid();
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
                                      sellerId: widget.sellerId, // Satıcının ID'si
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
