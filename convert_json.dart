import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  // singleKanji();
  multipleKanji();
  // buku();
} 

Future<void> buku() async {
  final singleFile = File('assets/data/single.json');
  final rawJson = await singleFile.readAsString();
  final json = jsonDecode(rawJson);
  final singleKanji = json['list'] as List;

  final multiFile = File('assets/data/multiple.json');
  final rawJson2 = await multiFile.readAsString();
  final json2 = jsonDecode(rawJson2);
  final multiKanji = json2['list'] as List;

  final kosakataFile = File('assets/data/_buku.json');
  final rawJson1 = await kosakataFile.readAsString();
  final json1 = jsonDecode(rawJson1) as Map;
  
  for (final name in json1.keys) {
    final values = json1[name] as Map;
    for (final key in values.keys) {
      final kanjis = values[key] as List;
      final newKanjis = <Map>[];
      for (final kanji in kanjis) {
        final index = singleKanji.indexWhere((element) => element['kana'] == kanji);
        if (index != -1) {
          final _singleKanji = singleKanji[index];
          newKanjis.add({
            'id': _singleKanji['id'],
            'kana': _singleKanji['kana'],
            'arti': _singleKanji['arti'],
            'romanji': _singleKanji['romanji'],
          });
        } else {
          final index2 = multiKanji.indexWhere((element) => element['kana'] == kanji);
          if (index2 != -1) {
            final _multiKanji = multiKanji[index2];
            newKanjis.add({
              'id': _multiKanji['id'],
              'kana': _multiKanji['kana'],
              'arti': _multiKanji['arti'],
              'romanji': _multiKanji['romanji'],
            });
          } else {
            print('Kanji not found: $kanji');
          } 
        }
      }
      values[key] = newKanjis;
    }
  }

  final newFile = File('assets/data/buku.json');
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
      for (final c in contoh) {
        c['arti'] = (c['arti'] as String).toLowerCase();
        c['romanji'] = (c['romanji'] as String).toLowerCase();
      }
    }
    newKanji.add(e);
  }
  
  final newFile = File('assets/data/single.json');
  await newFile.writeAsString(jsonEncode({
    'list': newKanji
  }));  
}

Future<void> multipleKanji() async {
  final oldFile = File('assets/data/_multiple.json');
  final rawJson = await oldFile.readAsString();
  final json = jsonDecode(rawJson);
  final allKanji = json['list'] as List;
  
  final newKanji = <Map>[];
  int i = 0;
  for (final e in allKanji) {
    e['id'] = i++;
    e['arti'] = (e['arti'] as String).toLowerCase();
    e['romanji'] = (e['romanji'] as String).toLowerCase();
    newKanji.add(e);
  }
  
  final newFile = File('assets/data/multiple.json');
  await newFile.writeAsString(jsonEncode({
    'list': newKanji
  }));  
}