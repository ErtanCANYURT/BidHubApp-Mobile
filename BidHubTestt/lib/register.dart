import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'register.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController identityNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? imageFile;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BidHub Register'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
                  child: imageFile == null ? Icon(Icons.add_a_photo) : null,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: 'Surname',
                ),
              ),
              SizedBox(height: 20.0),
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
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: identityNumberController,
                decoration: InputDecoration(
                  labelText: 'Identity Number',
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  // Kayıt işlemlerini gerçekleştir
                  String username = usernameController.text;
                  String name = nameController.text;
                  String surname = surnameController.text;
                  String email = emailController.text;
                  String password = passwordController.text;
                  String phoneNumber = phoneNumberController.text;
                  String identityNumber = identityNumberController.text;
                  String address = addressController.text;

                  // Kayıt işlemleri burada yapılabilir
                  // REST API endpointini ve gönderilecek verileri ayarlayın
                  String url = 'https://bidhubappprod.azurewebsites.net/api/User/AddUserAsync'; // API'nizin URL'sini buraya yazın
                  Map<String, String> headers = {'Content-Type': 'application/json'};
                  Map<String, String> jsonBody = {
                    'userName': username,
                    'name': name,
                    'surname': surname,
                    'password': password,
                    'phoneNumber': phoneNumber,
                    'identityNumber': identityNumber,
                    'address': address,
                    'email': email
                  };

                  try
                  {
                    http.Response response = await http.post(
                      Uri.parse(url),
                      headers: headers,
                      body: jsonEncode(jsonBody),
                    );

                    if (response.statusCode == 200) {
                      // Giriş işlemi başarılı olduğunda anasayfaya yönlendir
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      // İstek başarılı olmadıysa veya kullanıcı girişi hatalıysa hata mesajını gösterin
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text('Kayıt yapılamadı. Lütfen tekrar deneyin.'),
                            actions: [
                              TextButton(
                                child: Text('Tamam'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                  catch(e)
                  {
                  // İstek gönderilirken bir hata oluştuysa hata mesajını gösterin
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                  return AlertDialog(
                  title: Text('Hata'),
                  content: Text('Bir hata oluştu. Lütfen tekrar deneyin.'),
                  actions: [
                  TextButton(
                  child: Text('Tamam'),
                  onPressed: () {
                  Navigator.of(context).pop();
                  },
                  ),
                  ],
                  );
                  },
                  );
                  }
                  // Kayıt işlemi başarılı olduğunda anasayfaya yönlendir

                },
                child: Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
