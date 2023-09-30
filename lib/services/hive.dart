part of _service;

class HiveService {

  late final BoxCollection collection;

  Future<void> init() async {
    final directory = await getTemporaryDirectory();
    collection = await BoxCollection.open(
      'BelajarJepangBox',
      {'brightness', 'localization'},
      path: "${directory.path}/belajar_jepang_box",
    );
  }

  Future<CollectionBox<int>> brightnessBox() => collection.openBox<int>('brightness');
  Future<CollectionBox<String>> localizationBox() => collection.openBox<String>('localization');
}