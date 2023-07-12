import 'package:flutter/material.dart';

class AuctionDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Açık Artırma Detayı'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İlan Adı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Açık artırma adı gelecek'),
            SizedBox(height: 16),
            Text(
              'Açıklama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Açık artırma açıklaması gelecek'),
            SizedBox(height: 16),
            Text(
              'Şimdi Al Fiyatı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Şimdi al fiyatı gelecek'),
            SizedBox(height: 16),
            Text(
              'Başlangıç Fiyatı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('En yüksek teklif gelecek'),
            SizedBox(height: 16),
            Text(
              'En Yüksek Teklif',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Başlangıç fiyatı gelecek'),
            SizedBox(height: 16),
            Text(
              'Minimum Teklif Miktarı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Minimum teklif miktarı gelecek'),
            SizedBox(height: 16),
            Text(
              'Açık Artırma Başlangıç Tarihi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Açık artırma başlangıç tarihi gelecek'),
            SizedBox(height: 16),
            Text(
              'Açık Artırma Bitiş Tarihi',
              style: TextStyle(
                fontSize: 20,
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
                    },
                    child: Text('Satıcıyla İletişime Geç'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
