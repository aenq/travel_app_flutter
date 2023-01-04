import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart';
import 'package:tugas_akhir_pam/pages/home_page.dart';
import 'package:tugas_akhir_pam/pages/navpages/main_page.dart';
import 'package:tugas_akhir_pam/pages/register-page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(Login());
}

class Response {
  final String status;
  final String message;

  Response({required this.status, required this.message});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(status: json['status'], message: json['message']);
  }
}

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPage createState() => _LoginPage();
}

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
String _response = '';

class _LoginPage extends State<LoginPage> {

  Future _login() async {
    final response = await http.post(Uri.parse('http://192.168.43.252/mount-app/login.php'),
        body: {
          "username": username.text,
          "password": password.text,
        }
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final formKey = GlobalKey<FormState>(); //key for form
  String name="";
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: _formKey, //key for form
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:height*0.01),
                Text("Selamat datang kembali,", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                Text("silahkan masuk!", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                SizedBox(height: height*0.01,),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                      labelText: "Username"
                  ),
                  validator: (value) {
                    if(value!.isEmpty || RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$").hasMatch(value!)){
                      return "Username harus tanpa spasi";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: height*0.01,),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Kata sandi"
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Mohon isi kata sandi";
                    } else if (value == null || RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>').hasMatch(value!)) {
                      return "Kata sandi minimal 8 huruf";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          //  check if form data are valid
                          //  your process task ahead if all data are valid
                          _login();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                        }
                      }, child: Text('Masuk'),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF363f93),
                          primary: Colors.white
                      ),
                    )
                  ],
                ),
                SizedBox(height: height*0.03,),
                Text("Belum punya akun?", style: TextStyle(fontSize: 20, color: Color(0xFF363f93)),),
                TextButton(
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Daftar sekarang!',
                        style: TextStyle(color: Color(0xFF2e2e31), fontSize: 20),
                        textAlign: TextAlign.left),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                )
              ],
            ),
          ),
        )
    );
  }


}
