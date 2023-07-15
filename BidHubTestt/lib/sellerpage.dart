import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SellerPage extends StatefulWidget {
  final String sellerId;

  SellerPage({required this.sellerId});

  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  late Future<Map<String, dynamic>> sellerData;

  @override
  void initState() {
    super.initState();
    sellerData = fetchSellerData();
  }

  Future<Map<String, dynamic>> fetchSellerData() async {
    final response = await http.get(Uri.parse('https://bidhubappprod.azurewebsites.net/api/User/GetUserProfile?userId=${widget.sellerId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to fetch seller data. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch seller data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Satıcı Profili'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: sellerData,
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
            final seller = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Satıcı Adı: ${seller['name']}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Konum: ${seller['location']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'İletişim Bilgileri',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('E-posta Adresi'),
                    subtitle: Text(seller['email']),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Telefon Numarası'),
                    subtitle: Text(seller['phoneNumber']),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Konum'),
                    subtitle: Text(seller['address']),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Satıcıyı Puanla'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SellerRatingPage(sellerId: widget.sellerId)),
                      );
                    },
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

class SellerRatingPage extends StatefulWidget {
  final String sellerId;

  SellerRatingPage({required this.sellerId});

  @override
  _SellerRatingPageState createState() => _SellerRatingPageState();
}

class _SellerRatingPageState extends State<SellerRatingPage> {
  int _rating = 0;
  String _review = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Satıcıyı Puanla'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Puanınızı Seçin:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.star, color: _rating >= 1 ? Colors.orange : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _rating = 1;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star, color: _rating >= 2 ? Colors.orange : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _rating = 2;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star, color: _rating >= 3 ? Colors.orange : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _rating = 3;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star, color: _rating >= 4 ? Colors.orange : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _rating = 4;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star, color: _rating >= 5 ? Colors.orange : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _rating = 5;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Değerlendirme Notunuz:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _review = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Değerlendirme notunuzu girin',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Puanı ve değerlendirme notunu göndermek için işlemler
                // TODO: Puanı ve değerlendirme notunu gönderme işlemlerini tamamlayın
              },
              child: Text('Puanı Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}