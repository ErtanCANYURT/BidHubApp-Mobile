import 'package:flutter/material.dart';
import 'package:bidhubtestt/auctiondetail.dart';
import 'package:bidhubtestt/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> auctions;
  late List<String> filteredAuctions;

  @override
  void initState() {
    super.initState();
    auctions = [
      'Açık artırma 1',
      'Açık artırma 2',
      'Açık artırma 3',
      'Açık artırma 4',
      'Açık artırma 5',
      'Açık artırma 6',
    ];
    filteredAuctions = List.from(auctions);
  }

  void _filterAuctions(String keyword) {
    setState(() {
      filteredAuctions = auctions
          .where((auction) => auction.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Anasayfa'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                onChanged: _filterAuctions,
                decoration: InputDecoration(
                  labelText: 'Arama',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredAuctions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // İlgili açık artırma detay sayfasına yönlendirme işlemleri
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AuctionDetailPage(auctionName: filteredAuctions[index]),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/product_${index + 1}.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            filteredAuctions[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
