import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auctiondetail.dart';
import 'main.dart';

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
    auctions = [];
    filteredAuctions = [];
    fetchAuctions();
  }

  void fetchAuctions() async {
    try {
      final response = await http.get(
        Uri.parse('https://bidhubappprod.azurewebsites.net/auction/Auction/ListAllAuction'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        List<String> fetchedAuctions = data.map<String>((dynamic item) {
          final auctionName = item['auctionName'];
          final auctionid = item['id'];// Bu satırda "auctionName" alanını güncel JSON veri yapısına göre ayarlayın
          return auctionName.toString();
        }).toList();
        setState(() {
          auctions = fetchedAuctions;
          filteredAuctions = fetchedAuctions;
        });
      } else {
        // Handle error response
        print('Failed to fetch auctions. Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Failed to fetch auctions. Error: $e');
    }
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
