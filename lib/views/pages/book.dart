part of _view;

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BookController>();
    return FutureBuilder<Map>(
      future: controller.loadBuku(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          final kanjis = snapshot.data ?? {};
          if (kanjis.isNotEmpty) {
            final names = kanjis.keys.toList();
            return LayoutBuilder(
              builder: (context, box) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: SizedBox(
                      width: box.maxWidth > 400 ? 400 : box.maxWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => const SingleKanjiPage())
                              );
                            },
                            child: const Text('Single Kanji'),
                          ),
                          const SizedBox(height: 16,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => const KataKerjaPage())
                              );
                            },
                            child: const Text('Kata Kerja'),
                          ),
                          const SizedBox(height: 16,),
                          for (final name in names) ... [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, 
                                  MaterialPageRoute(builder: (context) => KosakataPage(
                                    name: name,
                                    kanjis: kanjis[name] ?? [],
                                  ))
                                );
                              },
                              child: Text((name as String).capitalize()),
                            ),
                            const SizedBox(height: 16,),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }else {
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
    );
  }
}