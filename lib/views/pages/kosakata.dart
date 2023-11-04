part of _view;

class KosakataPage extends StatelessWidget {
  const KosakataPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build kosakata page');
    final controller = context.read<BookController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kosakata'),
      ),
      body: FutureBuilder<Map>(
        future: controller.loadKosakata(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final kanjis = snapshot.data ?? {};
            if (kanjis.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: kanjis.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8,),
                itemBuilder: (context, index) {
                  final names = kanjis.keys.toList()[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((names as String).capitalize(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          for (final lists in kanjis[names].keys) ... [
                            Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.start,
                              spacing: 8,
                              children: [
                                for (final word in kanjis[names][lists]) ... [
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
                                        Text(word.romanji[0],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(word.arti[0],
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                              ],
                            ),
                            const SizedBox(height: 8,),
                            const Divider(height: 4, thickness: 4,)
                          ]
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