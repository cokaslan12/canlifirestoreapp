import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

FirebaseAuth _authkaydol = FirebaseAuth.instance;

class _StudentState extends State<Student> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _adi = TextEditingController();
  TextEditingController _soyadi = TextEditingController();
  TextEditingController _number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Yoklama Sistemi"),
      ),
      body: Center(
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (deger) {
                    if (deger!.length == null) {
                      return "Boş Geçilemez";
                    } else
                      null;
                  },
                  controller: _adi,
                  decoration: InputDecoration(
                    labelText: "Adı",
                    labelStyle: const TextStyle(
                        color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        fontFamily: "Loginfont"),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (deger) {
                    if (deger!.length == null) {
                      return "Boş Geçilemez";
                    } else
                      null;
                  },
                  controller: _soyadi,
                  decoration: InputDecoration(
                    labelText: "Soyadı",
                    labelStyle: const TextStyle(
                        color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        fontFamily: "Loginfont"),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (deger) {
                    if (deger!.length == null) {
                      return "Boş Geçilemez";
                    } else
                      null;
                  },
                  controller: _number,
                  decoration: InputDecoration(
                    labelText: "Numara",
                    labelStyle: const TextStyle(
                        color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        fontFamily: "Loginfont"),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: _yoklamaal, child: Text("Yoklama Al")),
                ElevatedButton(
                    onPressed: () async {
                      await _authkaydol.signOut();
                      Navigator.pop(context);
                    },
                    child: Text("Çıkış Yap")),
              ],
            )),
      ),
    );
  }

  void _yoklamaal() async {
    try {
      if (_formkey.currentState!.validate()) {
        var tarih = DateTime.now();
        var truedate = tarih.day.toString() +
            "." +
            tarih.month.toString() +
            "." +
            tarih.year.toString();
        var params = {
          "adi": _adi.text,
          "soyadi": _soyadi.text,
          "number": _number.text,
          "tarih": truedate
        };
        var response = await Dio().get(
          "https://nutkun.com/yoklama/yoklamagirdi.php",
          queryParameters: params,
          options: Options(
            method: "POST",
          ),
        );
      }
    } catch (e) {
      print("Hata: " + e.toString());
    }
  }
}
