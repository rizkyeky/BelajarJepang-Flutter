part of _controller;

class BookController {
  
  Future<List<KanjiModel>> loadSingleN5() async {
    final rawJson = await rootBundle.loadString('assets/data/single.json');
    final json = jsonDecode(rawJson);
    final list = (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
    return list.where((element) => element.contoh != null).toList();
  }

  Future<Map> loadKosakata() async {
    final rawJson = await rootBundle.loadString('assets/data/kosakata.json');
    final json = jsonDecode(rawJson) as Map;
    final result = {};
    for (final keys in json.keys) {
      final lists = json[keys] as Map;
      result[keys] = {};
      for (final listKey in lists.keys) {
        final list = lists[listKey] as List;
        result[keys][listKey] = list.map((e) => KanjiModel.fromJson(e)).toList();
      }
    }
    return result;
  }

  Future<List<KanjiModel>> loadKataKerja() async {
    final rawJson = await rootBundle.loadString('assets/data/kerja.json');
    final json = jsonDecode(rawJson) as Map;
    final list = (json['level1'] as List).map((e) => KanjiModel.fromJson(e)).toList();
    return list;
  }
}