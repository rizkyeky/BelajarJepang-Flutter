part of _util;

bool isKanji(String input) {
  final katakana = RegExp(r'[ァ-ン]');
  final hiragana = RegExp(r'[ぁ-ん]');
  return !input.contains(katakana) && !input.contains(hiragana);
}