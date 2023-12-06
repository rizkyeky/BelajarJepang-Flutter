import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  // singleKanji();
  kosakata();
}

Future<void> kosakata() async {
  final singleFile = File('assets/data/_single.json');
  final rawJson = await singleFile.readAsString();
  final json = jsonDecode(rawJson);
  final allKanji = json['list'] as List;

  final kosakataFile = File('assets/data/_kosakata.json');
  final rawJson1 = await kosakataFile.readAsString();
  final json1 = jsonDecode(rawJson1) as Map;
  
  for (final name in json1.keys) {
    final values = json1[name] as Map;
    for (final key in values.keys) {
      final kanjis = values[key] as List;
      final newKanjis = <Map>[];
      for (final kanji in kanjis) {
        final index = allKanji.indexWhere((element) => element['kanji'] == kanji);
        if (index != -1) {
          final singleKanji = allKanji[index];
          newKanjis.add({
            'id': singleKanji['id'],
            'kanji': singleKanji['kanji'],
            'arti': singleKanji['arti'],
            'romanji': singleKanji['romanji'],
          });
        }
      }
      values[key] = newKanjis;
    }
  }

  final newFile = File('assets/data/kosakata.json');
  await newFile.writeAsString(jsonEncode(json1));
}

Future<void> singleKanji() async {
  final oldFile = File('assets/data/_single.json');
  final rawJson = await oldFile.readAsString();
  final json = jsonDecode(rawJson);
  final allKanji = json['list'] as List;
  
  final newKanji = <Map>[];
  int i = 0;
  for (final e in allKanji) {
    e['id'] = i++;
    e['arti'] = (e['arti'] as String).toLowerCase();
    e['romanji'] = (e['romanji'] as String).toLowerCase();
    if (e.containsKey('contoh')) {
      final contoh = e['contoh'] as List;
      // final newContoh = <Map>[];
      for (final c in contoh) {
        c['arti'] = (c['arti'] as String).toLowerCase();
        c['romanji'] = (c['romanji'] as String).toLowerCase();
        // newContoh.add(c);
      }
      // e['contoh'] = newContoh;
    }
    newKanji.add(e);
  }
  
  final newFile = File('assets/data/single.json');
  await newFile.writeAsString(jsonEncode({
    'list': newKanji
  }));  
}