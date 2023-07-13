import 'package:flutter/material.dart';
import 'package:bidhubtestt/main.dart'; // MainTemplate import edildi

class SendMessagePage extends StatelessWidget {
  final String message; // 'message' parametresi eklendi

  SendMessagePage({required this.message}); // Constructor güncellendi

  @override
  Widget build(BuildContext context) {
    return MainTemplate( // MainTemplate kullanıldı
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mesaj Gönder'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  MessageBubble(
                    message: message,
                    isSender: false,
                  ),
                  MessageBubble(
                    message: 'Yeni mesaj',
                    isSender: true,
                  ),
                  MessageBubble(
                    message: 'Başka bir mesaj',
                    isSender: false,
                  ),
                  // Diğer mesajlar buraya eklenir
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Mesajınızı buraya yazın',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  IconButton(
                    onPressed: () {
                      // Mesaj gönderme işlemleri
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Mesajınız gönderildi'),
                        ),
                      );
                    },
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

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const MessageBubble({
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: isSender ? 80.0 : 8.0,
        right: isSender ? 8.0 : 80.0,
      ),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isSender ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              color: isSender ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
