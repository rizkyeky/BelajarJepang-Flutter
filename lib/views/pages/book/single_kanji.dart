part of _view;

class SingleKanjiPage extends StatelessWidget {
  const SingleKanjiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BookController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Kanji'),
      ),
      body: FutureBuilder<List<KanjiModel>>(
        future: controller.loadSingleN5(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final kanjis = snapshot.data ?? [];
            if (kanjis.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: kanjis.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8,),
                itemBuilder: (context, index) {
                  final kanji = kanjis[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(kanji.kana,
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(kanji.romanji.join(', '),
                                textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(kanji.arti.join(', '),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          if (kanji.contoh != null) Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (final contoh in kanji.contoh!) ... [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(contoh.kana,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16,),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(contoh.romanji.join(', '),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(contoh.arti.join(', ')),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(height: 8,)
                                ]
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              );
            } else {
              return const Center(
                child: Text('No Data'),
              );  
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}