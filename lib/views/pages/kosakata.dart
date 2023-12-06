part of _view;

class KosakataPage extends StatelessWidget {
  const KosakataPage({super.key,
    required this.name,
    required this.kanjis,
  });

  final String name;
  final Map kanjis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name.capitalize()),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
        itemCount: kanjis.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8,),
        itemBuilder: (context, index) {
          final name = kanjis.keys.toList()[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    children: [
                      for (final word in kanjis[name]) ... [
                        SizedBox(
                          width: 80,
                          child: Column(
                            children: [
                              Text(word.kana,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text((word.romanji[0] as String).capitalize(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text((word.arti[0] as String).capitalize(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}