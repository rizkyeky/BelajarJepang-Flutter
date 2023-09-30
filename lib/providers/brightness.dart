part of _provider;

class BrightnessProvider with ChangeNotifier {

  Brightness? _currBrightness;
  Brightness _platformBrightness;

  final CollectionBox<int> _box;

  BrightnessProvider({
    required Brightness platformBrightness, 
    required CollectionBox<int> box
  }) : 
    _platformBrightness = platformBrightness,
    _box = box
  {
    _currBrightness ??= _platformBrightness;
  }

  Brightness? get brightnessForTheme => _currBrightness;

  set brightnessFromPlatform(Brightness brightness) {
    _platformBrightness = brightness;
  }

  bool isBrightnessSystem() => _currBrightness == _platformBrightness;

  void setToDark() {
    if (_currBrightness != Brightness.dark) {
      _currBrightness = Brightness.dark;
      _saveBrightness(_currBrightness);
      notifyListeners();
    }
  }

  void setToLight() {
    if (_currBrightness != Brightness.light) {
      _currBrightness = Brightness.light;
      _saveBrightness(_currBrightness);
      notifyListeners();
    }
  }

  Future<void> loadBrightnessFromLocal() async {
    await _loadBrightness().then((index) {
      if (index != null) {
        _currBrightness = Brightness.values[index];
      }
    });
  }

  void setToDefaultSystem() {
    if (_currBrightness != null) {
      _currBrightness = null;
      _saveBrightness(_currBrightness);
      notifyListeners();
    }
  }

  static const String _key = 'BRIGHTNESSSTATUS';

  Future<void> _saveBrightness(Brightness? value) async {
    if (value != null) {
      await _box.put(_key, value.index);
    }
  }

  Future<int?> _loadBrightness() {
    return _box.get(_key);
  }

  Future<void> clearBrightness() {
    return _box.delete(_key);
  }
}