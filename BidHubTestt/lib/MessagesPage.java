import 'package:flutter/material.dart';
import 'package:bidhubtestt/main.dart'; // MainTemplate import edildi

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
              trailing: ElevatedButton(
                onPressed: () {
                  // Butona basıldığında mesajlaşma sayfasına yönlendirme yapılacak işlemler
                  // Örneğin, Navigator.push ile mesajlaşma sayfasına yönlendirilebilirsiniz.
                },
                child: Text('Mesajlaş'),
              ),
            );
          },
        ),
      ),
    );
  }
}
