import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bidhubtestt/main.dart';
import 'package:bidhubtestt/auctiondetail.dart';

class MyListingPage extends StatefulWidget {
  @override
  _MyListingPageState createState() => _MyListingPageState();
}

class _MyListingPageState extends State<MyListingPage> {
  List<dynamic> favoriteAuctions = []; // Holds the fetched favorite auctions

  @override
  void initState() {
    super.initState();
    fetchFavoriteAuctions();
  }

  Future<void> fetchFavoriteAuctions() async {
    final url = 'https://bidhubappprod.azurewebsites.net/favorite/Favorite/ListMyAllFavorites';

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);
      setState(() {
        favoriteAuctions = responseData as List<dynamic>;
      });
    } catch (error) {
      print('Error fetching favorite auctions: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorilerim'),
        ),
        body: ListView.builder(
          itemCount: favoriteAuctions.length,
          itemBuilder: (context, index) {
            final auctionId = favoriteAuctions[index]['auctionId'].toString();
            final auctionName = favoriteAuctions[index]['auctionName'];
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuctionDetailPage(
                        auctionId: auctionId,
                        auctionName: auctionName,
                        sellerId: '', // Set the actual seller ID
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/auction_$index.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auctionName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Açıklama',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Remove from favorites
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
