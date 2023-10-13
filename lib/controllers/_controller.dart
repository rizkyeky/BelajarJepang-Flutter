library _controller;

import 'dart:convert';
import 'dart:math';

import 'package:belajar_jepang/utils/_utils.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'quiz.dart';

class KanjiModel {
  final int id;
  final String kanji;
  final List<String> arti;
  final List<String> romanji;

  KanjiModel({
    required this.id,
    required this.kanji,
    required this.arti,
    required this.romanji,
  });

  factory KanjiModel.fromJson(Map<String, dynamic> json) => KanjiModel(
    id: json['id'],
    kanji: json['kanji'],
    arti: (json['arti'] as String).split('/').map((str) {
      if (str.isEmpty) {
        return str;
      }
      return str[0].toUpperCase() + str.substring(1).toLowerCase();
    }).toList(),
    romanji: (json['romanji'] as String).split('/').map((str) {
      if (str.isEmpty) {
        return str;
      }
      return str[0].toUpperCase() + str.substring(1).toLowerCase();
    }).toList(),
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