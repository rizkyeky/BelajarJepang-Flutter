part of _controller;

class QuizController {

  final fontFamilies = ['IBMPlexSansJP', 'KosugiMaru', 'NotoSansJP', 'NotoSerifJP', 'YujiMai', 'ZenKurenaido'];
  final selectedFonts = [];

  String getRandomFontFamily() {
    if (selectedFonts.length > 1) {
      final font = selectedFonts[Random().nextInt(selectedFonts.length)];
      return font;
    } else {
      return selectedFonts[0];
    }
  }

  Future<List<KanjiModel>> selectKanji(QuizType type) async {
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
    return kanji;
  }

  Future<List<KanjiModel>> startQuiz(QuizType type, int total, [bool onlyKanji = false]) async {
    
    final kanji = await selectKanji(type);

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
    final rawJson = await rootBundle.loadString('assets/data/single.json');
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
  
  final katakanaNormalMap = {
    'ア': 'a', 'イ': 'i', 'ウ': 'u', 'エ': 'e', 'オ': 'o',
    'カ': 'ka', 'キ': 'ki', 'ク': 'ku', 'ケ': 'ke', 'コ': 'ko',
    'サ': 'sa', 'シ': 'shi', 'ス': 'su', 'セ': 'se', 'ソ': 'so',
    'タ': 'ta', 'チ': 'chi', 'ツ': 'tsu', 'テ': 'te', 'ト': 'to',
    'ナ': 'na', 'ニ': 'ni', 'ヌ': 'nu', 'ネ': 'ne', 'ノ': 'no',
    'ハ': 'ha', 'ヒ': 'hi', 'フ': 'fu', 'ヘ': 'he', 'ホ': 'ho',
    'マ': 'ma', 'ミ': 'mi', 'ム': 'mu', 'メ': 'me', 'モ': 'mo',
    'ヤ': 'ya', 'ユ': 'yu', 'ヨ': 'yo',
    'ラ': 'ra', 'リ': 'ri', 'ル': 'ru', 'レ': 're', 'ロ': 'ro',
    'ワ': 'wa', 'ヲ': 'wo',
    'ガ': 'ga', 'ギ': 'gi', 'グ': 'gu', 'ゲ': 'ge', 'ゴ': 'go',
    'ザ': 'za', 'ジ': 'ji', 'ズ': 'zu', 'ゼ': 'ze', 'ゾ': 'zo',
    'ダ': 'da', 'ヂ': 'ji', 'ヅ': 'zu', 'デ': 'de', 'ド': 'do',
    'バ': 'ba', 'ビ': 'bi', 'ブ': 'bu', 'ベ': 'be', 'ボ': 'bo',
    'パ': 'pa', 'ピ': 'pi', 'プ': 'pu', 'ペ': 'pe', 'ポ': 'po',
    'ン': 'n',
  };

  final katakanaAddMap = {
    'キャ': 'kya', 'キュ': 'kyu', 'キョ': 'kyo',
    'シャ': 'sha', 'シュ': 'shu', 'ショ': 'sho',
    'チャ': 'cha', 'チュ': 'chu', 'チョ': 'cho',
    'ニャ': 'nya', 'ニュ': 'nyu', 'ニョ': 'nyo',
    'ヒャ': 'hya', 'ヒュ': 'hyu', 'ヒョ': 'hyo',
    'ミャ': 'mya', 'ミュ': 'myu', 'ミョ': 'myo',
    'リャ': 'rya', 'リュ': 'ryu', 'リョ': 'ryo',
    'ギャ': 'gya', 'ギュ': 'gyu', 'ギョ': 'gyo',
    'ジャ': 'ja', 'ジュ': 'ju', 'ジョ': 'jo',
    'ビャ': 'bya', 'ビュ': 'byu', 'ビョ': 'byo',
    'ファ': 'fa', 'フィ': 'fi', 'フェ': 'fe', 'フォ': 'fo',
    'ヴァ': 'va', 'ヴィ': 'vi', 'ヴ': 'vu', 'ヴェ': 've', 'ヴォ': 'vo',
    'ヴャ': 'vya', 'ヴュ': 'vyu', 'ヴョ': 'vyo',
  };

  final katakanaLongMap = {
    'アー': 'aa', 'イー': 'ii', 'ウー': 'uu', 'エー': 'ee', 'オー': 'oo',
    'カー': 'kaa', 'キー': 'kii', 'クー': 'kuu', 'ケー': 'kee', 'コー': 'koo',
    'サー': 'saa', 'シー': 'shii', 'スー': 'suu', 'セー': 'see', 'ソー': 'soo',
    'ター': 'taa', 'チー': 'chii', 'ツー': 'tsuu', 'テー': 'tee', 'トー': 'too',
    'ナー': 'naa', 'ニー': 'nii', 'ヌー': 'nuu', 'ネー': 'nee', 'ノー': 'noo',
    'ハー': 'haa', 'ヒー': 'hii', 'フー': 'fuu', 'ヘー': 'hee', 'ホー': 'hoo',
    'マー': 'maa', 'ミー': 'mii', 'ムー': 'muu', 'メー': 'mee', 'モー': 'moo',
    'ヤー': 'yaa', 'ユー': 'yuu', 'ヨー': 'yoo',
    'ラー': 'raa', 'リー': 'rii', 'ルー': 'ruu', 'レー': 'ree', 'ロー': 'roo',
    'ワー': 'waa', 'ヲー': 'woo',
    'ガー': 'gaa', 'ギー': 'gii', 'グー': 'guu', 'ゲー': 'gee', 'ゴー': 'goo',
    'ザー': 'zaa', 'ジー': 'jii', 'ズー': 'zuu', 'ゼー': 'zee', 'ゾー': 'zoo',
    'ダー': 'daa', 'ヂー': 'jii', 'ヅー': 'zuu', 'デー': 'dee', 'ドー': 'doo',
    'バー': 'baa', 'ビー': 'bii', 'ブー': 'buu', 'ベー': 'bee', 'ボー': 'boo',
    'パー': 'paa', 'ピー': 'pii', 'プー': 'puu', 'ペー': 'pee', 'ポー': 'poo',
  };

  (String, String) generateRandomKatakanaWord(int length, [bool withAdd=true, bool withLong=true]) {
    final random = Random(DateTime.now().millisecondsSinceEpoch);

    final katakanaBuffer = StringBuffer();
    final romanjiBuffer = StringBuffer();
    
    final katakanaChars = <String, String>{}
    ..addAll(katakanaNormalMap);

    if (withAdd) {
      katakanaChars.addAll(katakanaAddMap);
    }
    if (withLong) {
      katakanaChars.addAll(katakanaLongMap);
    }

    for (int i = 0; i < length; i++) {
      final randomIndex = random.nextInt(katakanaChars.length);
      
      final randomKatakana = katakanaChars.keys.toList()[randomIndex];
      final randomRomanji = katakanaChars.values.toList()[randomIndex];
      
      katakanaBuffer.write(randomKatakana);
      romanjiBuffer.write(randomRomanji);
    }
    
    return (katakanaBuffer.toString(), romanjiBuffer.toString());
  }

  bool checkKatakana(String katakana, String romajiInput) {

    final romajiBuffer = StringBuffer();
    int index = 0;

    final katakanaMap = {} 
    ..addAll(katakanaNormalMap)
    ..addAll(katakanaAddMap)
    ..addAll(katakanaLongMap);

    while (index < katakana.length) {
      String char = katakana[index];
      String nextChar = index < katakana.length - 1 ? katakana[index + 1] : '';

      final twoCharCombination = katakanaMap[char + nextChar];
      if (twoCharCombination != null) {
        romajiBuffer.write(twoCharCombination);
        index += 2;
      } else {
        final romaji = katakanaMap[char];
        if (romaji != null) {
          romajiBuffer.write(romaji);
        }
        if (char == 'ー') {
          final previousChar = katakana[index - 1];
          final previousRomaji = katakanaMap[previousChar];
          if (previousRomaji != null) {
            romajiBuffer.write(previousRomaji);
          }
        }
        index++;
      }
    }

    return romajiInput == romajiBuffer.toString();
  }
}