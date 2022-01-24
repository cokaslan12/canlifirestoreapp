import 'dart:convert';

import 'package:canlifirestoreapp/data_model/yoklama.dart';
import 'package:dio/dio.dart';

class YoklamaApi {
  Future<List<Yoklama>> fetchdata() async {
    try {
      var tarih = DateTime.now();
      var truetarih = tarih.day.toString() +
          "." +
          tarih.month.toString() +
          "." +
          tarih.year.toString();
      var response = await Dio().get(
          "https://nutkun.com/yoklama/yoklamaapi.php",
          queryParameters: {"tarih": truetarih});
      var jsonapi = jsonDecode(response.data.toString());
      List<Yoklama> gelenkullanici = [];
      if (response.statusCode == 200) {
        gelenkullanici =
            (jsonapi as List).map((e) => Yoklama.fromMap(e)).toList();
      }
      return gelenkullanici;
    } catch (_) {
      return Future.error(_.toString());
    }
  }
}
