import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'auctiondetail.dart';
import 'main.dart';
import 'Models/User.dart';

class HomePage extends StatefulWidget {
  final UserLoginDto? userLoginDto;

  const HomePage({Key? key, this.userLoginDto}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> auctions;
  late List<Map<String, dynamic>> filteredAuctions;

  @override
  void initState() {
    super.initState();
    auctions = [];
    filteredAuctions = [];
    fetchAuctions();
  }

  void fetchAuctions() async {
    try {
      String url = 'https://bidhubappprod.azurewebsites.net/auction/Auction/ListAllAuction';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.userLoginDto?.userAccessToken}'
      };
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        List<Map<String, dynamic>> fetchedAuctions = data.map<Map<String, dynamic>>((dynamic item) {
          final auctionName = item['auctionName'];
          final auctionId = item['id'];
          final sellerId = item['sellerId'];
          return {
            'id': auctionId,
            'auctionName': auctionName,
            'sellerId': sellerId,
          };
        }).toList();
        setState(() {
          auctions = fetchedAuctions;
          filteredAuctions = fetchedAuctions;
        });
      } else {
        print('Failed to fetch auctions. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch auctions. Error: $e');
    }
  }

  void _filterAuctions(String keyword) {
    setState(() {
      filteredAuctions = auctions
          .where((auction) => auction['auctionName'].toLowerCase().contains(keyword.toLowerCase()))
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
                  final auctionId = filteredAuctions[index]['id'].toString();
                  final sellerId = filteredAuctions[index]['sellerId'].toString();
                  final imagePath = 'assets/images/${index + 1}.jpg';
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AuctionDetailPage(
                            auctionId: auctionId,
                            auctionName: filteredAuctions[index]['auctionName'],
                            sellerId: sellerId,
                          ),
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
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            filteredAuctions[index]['auctionName'],
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
