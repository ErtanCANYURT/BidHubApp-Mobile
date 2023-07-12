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
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Mesajınız',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Mesajınızı buraya yazın',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Mesaj gönderme işlemleri
                    String messageText = 'Mesajınızı buradan alıcıya iletme işlemini gerçekleştirin.';
                    // İşlemler tamamlandıktan sonra mesajın alıcıya iletildiğine dair geribildirim sağlayabilirsiniz.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Mesajınız gönderildi'),
                      ),
                    );
                  },
                  child: Text('Mesaj Gönder'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
