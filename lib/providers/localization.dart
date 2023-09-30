part of _provider;

class LocalizationProvider with ChangeNotifier {

  Locale? _currLocale;
  
  final Locale _defaultLocale = const Locale('id');

  final CollectionBox<String> _box;

  LocalizationProvider({
    required CollectionBox<String> box,
  }) :
    _box = box
  {
    _loadLocale().then((code) {
      if (code != null) {
        _currLocale = Locale(code);
      }
    });
  }
  
  Locale get localeForApp => _currLocale ?? _defaultLocale;

  void changeLang() {
    if (_currLocale == null) {
      _currLocale = _defaultLocale;
    } else if (_currLocale?.languageCode == 'en') {
      _currLocale = const Locale('id');
    } else {
      _currLocale = const Locale('en');
    }
    _saveLocale(_currLocale);
    notifyListeners();
  }

  static const String _key = 'LOCALESTATUS';

  Future<void> _saveLocale(Locale? value) async {
    if (value != null) {
      await _box.put(_key, value.languageCode);
    } else if ((await _box.get(_key)) != null) {
      await _box.delete(_key);
    }
  }

  Future<String?> _loadLocale() {
    return _box.get(_key);
  }
}