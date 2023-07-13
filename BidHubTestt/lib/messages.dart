import 'package:flutter/material.dart';
import 'package:bidhubtestt/main.dart'; // MainTemplate import edildi
import 'package:bidhubtestt/sendmessage.dart'; // SendMessagePage import edildi

class MessagesPage extends StatelessWidget {
  final List<String> messages = [
    'Merhaba!',
    'Nasıl gidiyor?',
    'Hala ilanda mı?',
    'Teşekkürler!'
  ];

  @override
  Widget build(BuildContext context) {
    return MainTemplate( // MainTemplate kullanıldı
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mesajlarım'),
        ),
        body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                messages[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Son mesajın tarihi'),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // SendMessagePage sayfasına mesajın içeriğini ve diğer verileri gönderme işlemi
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SendMessagePage(message: messages[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
