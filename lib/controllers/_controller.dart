library _controller;

import 'dart:convert';
import 'dart:math';

// import 'package:belajar_jepang/utils/_utils.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'quiz.dart';
part 'book.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

List<String> str2List(String str) => str.split('/').map((str) {
  if (str.isEmpty) {
    return str;
  }
  return str.capitalize();
}).toList();

class KanjiModel {
  final int id;
  final String kana;
  final List<String> arti;
  final List<String> romanji;
  final List<ContohKanji>? contoh;
  final List<BentukKerja>? bentuk;

  KanjiModel({
    required this.id,
    required this.kana,
    required this.arti,
    required this.romanji,
    this.contoh,
    this.bentuk,
  });

  factory KanjiModel.fromJson(Map<String, dynamic> json) => KanjiModel(
    id: json['id'],
    kana: json['kana'],
    arti: str2List(json['arti'] as String),
    romanji: str2List(json['romanji'] as String),
    contoh: json['contoh'] != null ? (json['contoh'] as List).map((e) => ContohKanji.fromJson(e)).toList() : null,
    bentuk: () {
      final temp = <BentukKerja>[];
      if (json['bentuk'] != null) {
        final bentuk = json['bentuk'] as Map;
        for (final key in bentuk.keys) {
          final kerja = BentukKerja.fromJson(json['bentuk'][key], key);
          temp.add(kerja);
        }
      }
      return temp;
    }(),
  );
}

enum KatakanaType {
  normal,
  add,
  long
}

enum QuizType {
  singleKanji,
  multipleKanji,
  katakana,
  hiragana
}

class ContohKanji {
  final String kana;
  final List<String> arti;
  final List<String> romanji;

  ContohKanji({
    required this.kana,
    required this.arti,
    required this.romanji,
  });

  factory ContohKanji.fromJson(Map<String, dynamic> json) => ContohKanji(
    kana: json['kana'],
    arti: str2List(json['arti'] as String),
    romanji: str2List(json['romanji'] as String),
  );
}

class BentukKerja {
  final String type;
  final String kana;
  final String romanji;
  final String? contoh;

  BentukKerja({
    required this.type,
    required this.kana,
    required this.romanji,
    this.contoh,
  });

  factory BentukKerja.fromJson(Map<String, dynamic> json, String type) {
    String temp = type;
    switch (type) {
      case 'positif':
        temp = 'Positif Sopan';
        break;
      case 'negatif':
        temp = 'Negatif Sopan';
        break;
      case 'negatif2':
        temp = 'Negatif Kasual';
        break;
      case 'past':
        temp = 'Past Sopan';
        break;
      case 'past2':
        temp = 'Past Kasual';
        break;
      case 'past_negatif':
        temp = 'Past Negatif Kasual';
        break;
      case 'command':
        temp = 'Perintah Sopan';
        break;
      case 'command2':
        temp = 'Perintah Kasual';
        break;
      case 'want':
        temp = 'Keinginan';
        break;
      default:
        temp = type;
    }
    return BentukKerja(
    type: temp,
    kana: json['kana'],
    romanji: json['romanji'] as String,
    contoh: json['contoh'] != null ? json['contoh'] as String : null,
  );
  }
}