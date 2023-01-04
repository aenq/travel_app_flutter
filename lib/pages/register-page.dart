import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tugas_akhir_pam/pages/home_page.dart';
import 'package:tugas_akhir_pam/pages/login_page.dart';
import 'package:tugas_akhir_pam/pages/navpages/main_page.dart';
import 'package:http/http.dart' as http;


void main(){
  runApp(Register());
}

class Register extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPage createState() => _RegisterPage();
}

TextEditingController namaLengkap = TextEditingController();
TextEditingController username = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController noHP = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController cpassword = TextEditingController();



class _RegisterPage extends State<RegisterPage> {

  Future _registData() async {
    final response = await http.post(Uri.parse('http://localhost/mount-app-mongo/register.php'),
    body: {
      "namaLengkap": namaLengkap.text,
      "username": username.text,
      "email": email.text,
      "noHP": noHP.text,
      "password": password.text,
      "cpassword": cpassword.text,
        }
    );
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    return false;
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Form(
              key: _formKey, //key for form
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:height*0.01),
                  Text("Satu langkah lagi,", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                  Text("buat akun terlebih dulu!", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                  SizedBox(height: height*0.01,),
                  TextFormField(
                    controller: namaLengkap,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap"
                    ),
                    validator: (value) {
                      if(value!.isNotEmpty && value.length > 2) {
                        return null;
                      } else if (value.length <3 && value.isNotEmpty) {
                        return "Nama kurang panjang";
                      } else {
                        return "Mohon masukkan nama";
                      }
                    },
                  ),
                  SizedBox(height: height*0.02,),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        labelText: "Username"
                    ),
                    validator: (value) {
                      if(value!.isEmpty || RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$").hasMatch(value!)){
                        return "Pastikan username tanpa spasi dan karakter spesial";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: height*0.01,),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: "Email"
                    ),
                    validator: (value) {
                      if(value!.isEmpty || !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value!)){
                        return "Email tidak valid";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: height*0.01,),
                  TextFormField(
                    controller: noHP,
                    decoration: InputDecoration(
                        labelText: "Nomor HP"
                    ),
                    validator: (value) {
                      if (value?.length != 13)
                        return 'Pastikan anda menggunakan kode negara +62';
                      else
                        return null;
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
                      if(value == null || RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>').hasMatch(value!)){
                        return "Mohon isi kata sandi";
                      } else if (value.length < 8) {
                        return "Kata sandi minimal 8 huruf";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height*0.01,),
                  TextFormField(
                    controller: cpassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Konfirmasi kata sandi"
                    ),
                      validator: (value){
                        if(value == null)
                          return 'Mohon masukkan kata sandi';
                        if(value != password.text)
                          return 'Kata sandi tidak sama';
                        return null;
                      }
                  ),
                  SizedBox(height: height*0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            _registData().then((value) {
                              if(value) {
                                final snackBar = SnackBar(content: const Text("Berhasil terdaftar"));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBar(content: const Text("Coba ulangi proses pendaftaran"));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            });
                            print("Berhasil terdaftar!");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                          }
                        }, child: Text('Daftar'),
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF363f93),
                            primary: Colors.white
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.03,),
                  Text("Sudah punya akun?", style: TextStyle(fontSize: 20, color: Color(0xFF363f93)),),
                  TextButton(
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Masuk!',
                          style: TextStyle(color: Color(0xFF2e2e31), fontSize: 20),
                          textAlign: TextAlign.left),
                    ),
                    onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

                  },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

}
