part of _controller;

class QuizController {

  String getRandomFontFamily() {
    final fontFamilies = ['IBMPlexSansJP', 'KosugiMaru', 'NotoSansJP', 'NotoSerifJP', 'YujiMai', 'ZenKurenaido'];
    final font = fontFamilies[Random().nextInt(fontFamilies.length)];
    return font;
  }

  Future<List<KanjiModel>> startQuiz(QuizType type, int total, [bool onlyKanji = false]) async {
    
    final List<KanjiModel> kanji = [];
    switch (type) {
      case QuizType.satuKanji:
        kanji.addAll(await loadSingleN5());
      break;
      case QuizType.semuaKanji:
        kanji.addAll(await loadSayurBuah());
        kanji.addAll(await loadSifat());
        kanji.addAll(await loadHewan());
        kanji.addAll(await loadCuaca());
        kanji.addAll(await loadPekerjaan());
        kanji.addAll(await loadKerja());
      break;
      case QuizType.kataSifat:
        kanji.addAll(await loadSifat());
      break;
      case QuizType.kataBenda:
        kanji.addAll(await loadBenda());
      break;
      case QuizType.kataKerja:
        kanji.addAll(await loadKerja());
      break;
      case QuizType.kataSayurBuah:
        kanji.addAll(await loadSayurBuah());
      break;
      case QuizType.kataHewan:
        kanji.addAll(await loadHewan());
      break;
      case QuizType.kataCuaca:
        kanji.addAll(await loadCuaca());
      break;
      case QuizType.kataPekerjaan:
        kanji.addAll(await loadPekerjaan());
      break;
    }
    if (onlyKanji) {
      final temp = kanji.where((element) => isKanji(element.kanji)).toList();
      kanji.clear();
      kanji.addAll(temp);
    }
    final len = kanji.length > total ? total : kanji.length;
    final seed = DateTime.now().millisecondsSinceEpoch;
    final indexs = List<int>.generate(len, (i) => i)
      ..shuffle(Random(seed));
    kanji.shuffle(Random(seed));
    final newKanji = indexs.map((e) => kanji[e]).toList();
    return newKanji;
  }

  Future<List<KanjiModel>> loadSingleN5() async {
    final rawJson = await rootBundle.loadString('assets/data/single_n5.json');
    final json = jsonDecode(rawJson);
    return (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
  }

  Future<List<KanjiModel>> loadCuaca() async {
    final rawJson = await rootBundle.loadString('assets/data/cuaca.json');
    final json = jsonDecode(rawJson);
    return (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
  }

  Future<List<KanjiModel>> loadHewan() async {
    final rawJson = await rootBundle.loadString('assets/data/hewan.json');
    final json = jsonDecode(rawJson);
    return (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
  }

  Future<List<KanjiModel>> loadSifat() async {
    final rawJson = await rootBundle.loadString('assets/data/sifat.json');
    final json = jsonDecode(rawJson);
    return (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
  }

  Future<List<KanjiModel>> loadBenda() async {
    final rawJson = await rootBundle.loadString('assets/data/benda.json');
    final json = jsonDecode(rawJson);
    return (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
  }

  Future<List<KanjiModel>> loadPekerjaan() async {
    final rawJson = await rootBundle.loadString('assets/data/pekerjaan.json');
    final json = jsonDecode(rawJson);
    return (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
  }

  Future<List<KanjiModel>> loadSayurBuah() async {
    final rawJson = await rootBundle.loadString('assets/data/sayur_buah.json');
    final json = jsonDecode(rawJson);
    return (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
  }

  Future<List<KanjiModel>> loadKerja() async {
    final rawJson = await rootBundle.loadString('assets/data/kerja.json');
    final json = jsonDecode(rawJson);
    return (json['list'] as List).map((e) => KanjiModel.fromJson(e)).toList();
  }
}