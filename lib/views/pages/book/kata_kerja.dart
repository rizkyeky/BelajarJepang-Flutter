part of _view;

class KataKerjaPage extends StatelessWidget {
  const KataKerjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BookController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kata Kerja'),
      ),
      body: FutureBuilder<List<KanjiModel>>(
        future: controller.loadKataKerja(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final kerjas = snapshot.data ?? [];
            if (kerjas.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
                itemCount: kerjas.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8,),
                itemBuilder: (context, indexFirst) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(kerjas[indexFirst].kana,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kerjas[indexFirst].romanji.join(', '),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(kerjas[indexFirst].arti.join(', '),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              
                            ],
                          ),
                          const SizedBox(height: 16,),
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => const SizedBox(width: 8,),
                              itemCount: kerjas[indexFirst].bentuk?.length ?? 0,
                              itemBuilder: (context, indexSecond) {
                                final bentuk = kerjas[indexFirst].bentuk?[indexSecond];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bentuk?.kana ?? '',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(bentuk?.romanji.capitalize() ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(bentuk?.type ?? ''),
                                  ],
                                );
                              },
                            ),
                          ),
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