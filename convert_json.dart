import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final file = File('assets/data/single.json');
  final rawJson = await file.readAsString();
  final json = jsonDecode(rawJson);
  final allKanji = json['list'] as List;
  
  final newKanji = <Map<String, dynamic>>[];
  int i = 0;
  for (final e in allKanji) {
    e['id'] = i++;
    // e['arti'] = (e['arti'] as String).toLowerCase();
    // e['romanji'] = (e['romanji'] as String).toLowerCase();
    newKanji.add(e);
    // for (final f in allKanji) {
    //   if (e['kanji'] == f['kanji']) {
    //     i++;
    //   }
    // }
    // if (i > 1) {
    //   print(e['kanji']);
    // }
    // i = 0;
  }
  // print(newKanji[0]);
  // print(newKanji[newKanji.length-1]);
  
  await file.writeAsString(jsonEncode({
    'list': newKanji
  }));  
}