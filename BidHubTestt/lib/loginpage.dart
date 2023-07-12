import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BidHub Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Email ve parola değerlerini al ve giriş işlemlerini gerçekleştir
                String email = emailController.text;
                String password = passwordController.text;
                // Giriş işlemleri burada yapılabilir

                // Giriş işlemi başarılı olduğunda anasayfaya yönlendir
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('Giriş Yap'),
            ),
            SizedBox(height: 20.0),
            Text('veya'),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                // Facebook ile giriş yapma işlemleri burada gerçekleştirilebilir
              },
              icon: Icon(Icons.facebook),
              label: Text('Facebook ile Giriş Yap'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                // Google ile giriş yapma işlemleri burada gerçekleştirilebilir
              },
              icon: Icon(Icons.g_translate),
              label: Text('Google ile Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
