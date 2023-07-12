import 'package:flutter/material.dart';
import 'package:bidhubtestt/auctiondetail.dart';
import 'package:bidhubtestt/main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Anasayfa'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<String>>(
                future: fetchNewAuctions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // İlgili açık artırma detay sayfasına yönlendirme işlemleri
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AuctionDetailPage(),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> fetchNewAuctions() async {
    await Future.delayed(Duration(seconds: 2));
    return ['Açık artırma 1', 'Açık artırma 2', 'Açık artırma 3', 'Açık artırma 4', 'Açık artırma 5', 'Açık artırma 6'];
  }
}
