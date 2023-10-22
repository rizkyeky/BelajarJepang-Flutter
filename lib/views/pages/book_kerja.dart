part of _view;

class BookKerjaPage extends StatelessWidget {
  const BookKerjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build BookKerja page');
    final controller = context.read<BookController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kata Kerja'),
      ),
      body: FutureBuilder<List<KanjiModel>>(
        future: controller.loadKataKerja(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.stackTrace);
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final kerjas = snapshot.data ?? [];
            if (kerjas.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: kerjas.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8,),
                itemBuilder: (context, index) {
                  // final names = kanjis.keys.toList()[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(kerjas[index].kana,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(kerjas[index].romanji.join(', '),
                                  ),
                                ],
                              ),
                              Text(kerjas[index].arti.join(', '),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          for (final bentuk in kerjas[index].bentuk!) ... [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bentuk.kana,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(bentuk.romanji.capitalize(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(bentuk.type),
                              ],
                            ),
                            const Divider(height: 8,),
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