import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final Bid bid;

  PaymentPage({required this.bid});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String cardNumber = '';
  String cardHolderName = '';
  String expirationDate = '';
  String cvv = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ödeme'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teklif ID: ${widget.bid.id}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Açık artırma: ${widget.bid.auctionName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Teklif Miktarı: ${widget.bid.amount} TL',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Text(
              'Kart Bilgileri',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Kart Numarası'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  cardNumber = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Kart Sahibinin Adı'),
              onChanged: (value) {
                setState(() {
                  cardHolderName = value;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Son Kullanma Tarihi'),
                    onChanged: (value) {
                      setState(() {
                        expirationDate = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'CVV'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Ödeme işlemleri gerçekleştirilir
              },
              child: Text('Ödemeyi Tamamla'),
            ),
          ],
        ),
      ),
    );
  }
}

class Bid {
  final String id;
  final String auctionName;
  final double amount;
  final DateTime date;
  final String status;

  Bid({
    required this.id,
    required this.auctionName,
    required this.amount,
    required this.date,
    required this.status,
  });
}
