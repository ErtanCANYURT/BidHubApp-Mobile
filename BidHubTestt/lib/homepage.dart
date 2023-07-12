import 'package:flutter/material.dart';
import 'package:bidhubtestt/main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      child: Scaffold(
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
                        return ListTile(
                          title: Text(snapshot.data![index]),
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

// Diğer sayfaları da aynı şekilde MainTemplate ile sarmalayarak ekleyebilirsiniz.


  Future<List<String>> fetchNewAuctions() async {
    await Future.delayed(Duration(seconds: 2));
    return ['Açık artırma 1', 'Açık artırma 2', 'Açık artırma 3', 'Açık artırma 4', 'Açık artırma 5', 'Açık artırma 6'];
  }
}
