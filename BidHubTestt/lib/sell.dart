import 'dart:convert';
import 'Utils//constants.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart' as http;

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  TextEditingController ilanAdiController = TextEditingController();
  TextEditingController aciklamaController = TextEditingController();
  TextEditingController simdiAlFiyatiController = TextEditingController();
  TextEditingController baslangicFiyatiController = TextEditingController();
  TextEditingController minTeklifMiktariController = TextEditingController();
  TextEditingController baslangicTarihiController = TextEditingController();
  TextEditingController bitisTarihiController = TextEditingController();

  void publishAd(
      String ilanAdi,
      String aciklama,
      double simdiAlFiyati,
      double baslangicFiyati,
      double minTeklifMiktari,
      String baslangicTarihi,
      String bitisTarihi) {
    // İlanı yayımlama işlemleri
    // TODO: Hizmete istek gönderme veya veritabanına kaydetme işlemleri
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Satış Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'İlan Adı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: ilanAdiController,
              decoration: InputDecoration(
                hintText: 'İlan adını girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Açıklama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: aciklamaController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'İlan açıklamasını girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Şimdi Al Fiyatı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: simdiAlFiyatiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Şimdi al fiyatını girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Başlangıç Fiyatı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: baslangicFiyatiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Başlangıç fiyatını girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Minimum Teklif Miktarı',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: minTeklifMiktariController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Minimum teklif miktarını girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Açık Artırma Başlangıç Tarihi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              controller: baslangicTarihiController,
              decoration: InputDecoration(
                hintText: 'Açık artırma başlangıç tarihini seçin',
                border: OutlineInputBorder(),
              ),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              dateLabelText: 'Tarih',
              timeLabelText: 'Saat',
              onChanged: (val) {},
              validator: (val) {
                return null;
              },
              onSaved: (val) {},
            ),
            SizedBox(height: 16),
            Text(
              'Açık Artırma Bitiş Tarihi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              controller: bitisTarihiController,
              decoration: InputDecoration(
                hintText: 'Açık artırma bitiş tarihini seçin',
                border: OutlineInputBorder(),
              ),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              dateLabelText: 'Tarih',
              timeLabelText: 'Saat',
              onChanged: (val) {},
              validator: (val) {
                return null;
              },
              onSaved: (val) {},
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String ilanAdi = ilanAdiController.text;
                String aciklama = aciklamaController.text;
                double simdiAlFiyati = double.parse(simdiAlFiyatiController.text);
                double baslangicFiyati = double.parse(baslangicFiyatiController.text);
                double minTeklifMiktari = double.parse(minTeklifMiktariController.text);
                String baslangicTarihi = baslangicTarihiController.text;
                String bitisTarihi = bitisTarihiController.text;

                DateTime baslangicDateTime = DateTime.parse(baslangicTarihi);
                DateTime bitisDateTime = DateTime.parse(bitisTarihi);

                String url = 'https://bidhubappprod.azurewebsites.net/auction/Auction/AddAsync'; // API'nizin URL'sini buraya yazın
                Map<String, String> headers = {'Content-Type': 'application/json'};
                Map<String, dynamic> jsonBody = {
                  'Name': ilanAdi,
                  'Description': aciklama,
                  'BuyNowPrice': simdiAlFiyati.toString(),
                  'StartingPrice': baslangicFiyati.toString(),
                  'MinBidAmour': minTeklifMiktari.toString(),
                  'StartDate': baslangicDateTime.toIso8601String(),
                  'EndDate': bitisDateTime.toIso8601String(),
                };

                try {
                  http.Response response = await http.post(
                    Uri.parse(url),
                    headers: headers,
                    body: jsonEncode(jsonBody),
                  );

                  // İstek başarılıysa ve kullanıcı girişi onaylandıysa
                  if (response.statusCode == 200) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // İstek başarılı olmadıysa veya kullanıcı girişi hatalıysa hata mesajını gösterin
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hata'),
                          content: Text('Mezat oluşturulamadı. Lütfen tekrar deneyin.'),
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
              child: Text('İlanı Yayımla'),
            ),
          ],
        ),
      ),
    );
  }
}
