// To parse this JSON data, do
//
//     final yoklama = yoklamaFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Yoklama> yoklamaFromMap(String str) => List<Yoklama>.from(json.decode(str).map((x) => Yoklama.fromMap(x)));

String yoklamaToMap(List<Yoklama> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Yoklama {
    Yoklama({
        required this.id,
        required this.name,
        required this.surname,
        required this.numaras,
        required this.yoklamatarihi,
    });

    final String id;
    final String name;
    final String surname;
    final String numaras;
    final String yoklamatarihi;

    factory Yoklama.fromMap(Map<String, dynamic> json) => Yoklama(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        numaras: json["numarası"],
        yoklamatarihi: json["yoklamatarihi"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "surname": surname,
        "numarası": numaras,
        "yoklamatarihi": yoklamatarihi,
    };
}
