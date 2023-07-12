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
              title: Text(messages[index]),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  // SendMessagePage sayfasına mesajın içeriğini ve diğer verileri gönderme işlemi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SendMessagePage(message: messages[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
