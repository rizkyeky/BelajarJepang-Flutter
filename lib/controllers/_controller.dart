library _controller;

import 'dart:convert';
import 'dart:math';

import 'package:belajar_jepang/utils/_utils.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'quiz.dart';

class KanjiModel {
  final int id;
  final String kanji;
  final String arti;
  final String romanji;

  KanjiModel({
    required this.id,
    required this.kanji,
    required this.arti,
    required this.romanji,
  });

  factory KanjiModel.fromJson(Map<String, dynamic> json) => KanjiModel(
    id: json['id'],
    kanji: json['kanji'],
    arti: json['arti'],
    romanji: json['romanji'],
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