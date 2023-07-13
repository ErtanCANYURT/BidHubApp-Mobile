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
                _performPayment();
              },
              child: Text('Ödemeyi Tamamla'),
            ),
          ],
        ),
      ),
    );
  }

  void _performPayment() {
    // Burada gerçek ödeme işlemleri gerçekleştirilebilir
    // Örneğin, bir ödeme geçidi entegrasyonu yapılabilir
    // Kart bilgileri ve teklif bilgileri kullanılarak ödeme tamamlanabilir
    // Bu örnek kodda sadece metin alanlarının doldurulduğunu varsayıyoruz
    // Gerçek bir ödeme entegrasyonunda güvenlik önlemleri alınmalıdır
    // Ödeme başarılıysa işlem sonucu kullanıcıya bildirilebilir veya yönlendirilebilir
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ödeme Tamamlandı'),
          content: Text('Ödeme işlemi başarıyla tamamlandı.'),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class MyBidsPage extends StatelessWidget {
  final List<Bid> bids = [
    Bid(
      id: '1',
      auctionName: 'Açık artırma 1',
      amount: 150,
      date: DateTime.now(),
      status: 'Kabul Edildi',
    ),
    Bid(
      id: '2',
      auctionName: 'Açık artırma 2',
      amount: 200,
      date: DateTime.now(),
      status: 'Beklemede',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tekliflerim'),
      ),
      body: ListView.builder(
        itemCount: bids.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Teklif ID: ${bids[index].id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Açık artırma: ${bids[index].auctionName}'),
                  Text('Teklif Miktarı: ${bids[index].amount} TL'),
                  Text('Tarih: ${bids[index].date.toString()}'),
                  Text('Durum: ${bids[index].status}'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BidDetailPage(bid: bids[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BidDetailPage extends StatelessWidget {
  final Bid bid;

  BidDetailPage({required this.bid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teklif Detayı'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Teklif ID: ${bid.id}'),
            Text('Açık artırma: ${bid.auctionName}'),
            Text('Teklif Miktarı: ${bid.amount} TL'),
            Text('Tarih: ${bid.date.toString()}'),
            Text('Durum: ${bid.status}'),
            // Diğer detaylar eklenebilir
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(bid: bid),
                  ),
                );
              },
              child: Text('Ödeme Yap'),
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
