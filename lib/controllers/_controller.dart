library _controller;

import 'dart:convert';
import 'dart:math';

import 'package:belajar_jepang/utils/_utils.dart';
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
  final String kanji;
  final List<String> arti;
  final List<String> romanji;
  final List<ContohKanji>? contoh;

  KanjiModel({
    required this.id,
    required this.kanji,
    required this.arti,
    required this.romanji,
    this.contoh,
  });

  factory KanjiModel.fromJson(Map<String, dynamic> json) => KanjiModel(
    id: json['id'],
    kanji: json['kanji'],
    arti: str2List(json['arti'] as String),
    romanji: str2List(json['romanji'] as String),
    contoh: json['contoh'] != null ? (json['contoh'] as List).map((e) => ContohKanji.fromJson(e)).toList() : null,
  );
}

enum QuizType {
  satuKanji,
  semuaKanji,
  kataSifat,
  kataBenda,
  kataKerja,
  kataSayurBuah,
  kataHewan,
  kataCuaca,
  kataPekerjaan,
}

enum KatakanaType {
  normal,
  add,
  long
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