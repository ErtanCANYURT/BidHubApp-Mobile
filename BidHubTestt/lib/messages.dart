import 'package:flutter/material.dart';
import 'package:bidhubtestt/main.dart'; // MainTemplate import edildi

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainTemplate( // MainTemplate kullanıldı
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mesajlarım'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Mesaj $index'),
                  );
                },
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mesajınızı girin...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
