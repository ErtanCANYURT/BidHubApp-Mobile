import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'register.dart';

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
                launch('https://www.facebook.com/login');
              },
              icon: Icon(Icons.facebook),
              label: Text('Facebook ile Giriş Yap'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                // Google ile giriş yapma işlemleri burada gerçekleştirilebilir
                launch('https://accounts.google.com/v3/signin/identifier?dsh=S-1962814945%3A1689269180606003&continue=https%3A%2F%2Faccounts.google.com%2F&followup=https%3A%2F%2Faccounts.google.com%2F&ifkv=AeDOFXh_eKwYwCQ9juNxGolJFkl2K5cLMwgODhnewEzOAaIvdU6ropRk4VPST09SkR3UahmWVYtzfw&passive=1209600&flowName=GlifWebSignIn&flowEntry=ServiceLogin');
              },
              icon: Icon(Icons.g_translate),
              label: Text('Google ile Giriş Yap'),
            ),
            SizedBox(height: 20.0),
            Text("Henüz hesabın yok mu?"),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Kayıt ol sayfasına yönlendirme işlemleri
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
