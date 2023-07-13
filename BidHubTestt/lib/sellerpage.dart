import 'package:flutter/material.dart';

class SellerPage extends StatelessWidget {
  final String sellerName;
  final String sellerLocation;

  SellerPage({required this.sellerName, required this.sellerLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Satıcı Profili'),
      ),
      body: SingleChildScrollView(
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
              'Satıcı Adı: $sellerName',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Konum: $sellerLocation',
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
              subtitle: Text('satıcı@mail.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Telefon Numarası'),
              subtitle: Text('1234567890'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Konum'),
              subtitle: Text('İstanbul, Türkiye'),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Satıcıyı Puanla'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellerRatingPage(sellerName: sellerName)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SellerRatingPage extends StatefulWidget {
  final String sellerName;

  SellerRatingPage({required this.sellerName});

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
              'Satıcı Adı: ${widget.sellerName}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
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
