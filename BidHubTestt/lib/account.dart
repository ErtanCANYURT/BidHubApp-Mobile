import 'package:flutter/material.dart';
import 'package:bidhubtestt/main.dart';
import 'package:bidhubtestt/myorderspage.dart';
import 'package:bidhubtestt/mybidspage.dart';
import 'Utils//constants.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
              ),
              SizedBox(height: 16),
              Text(
                Constants.user.userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                Constants.user.email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'İletişim Bilgileri',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('E-posta Adresi'),
                subtitle: Text(Constants.user.email),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Telefon Numarası'),
                subtitle: Text(Constants.user.phoneNumber),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Adres'),
                subtitle: Text(Constants.user.address),
              ),
              SizedBox(height: 16),
              Text(
                'Hesap Ayarları',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Şifre Değiştir'),
                onTap: () {
                  // Şifre değiştirme işlemleri için yönlendirme yapılabilir
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_basket),
                title: Text('Siparişlerim'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyOrdersPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Tekliflerim'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyBidsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Çıkış Yap'),
                onTap: () {
                  // Çıkış yapma işlemleri
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
