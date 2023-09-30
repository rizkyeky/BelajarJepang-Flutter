part of _view;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final brightnessProvider = context.read<BrightnessProvider>();
    // final localeProvider = context.read<LocalizationProvider>();
    debugPrint('build home page');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Setting'),
                onTap: () => Routemaster.of(context).push('/setting'),
              )
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: LayoutBuilder(
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
                        Routemaster.of(context).push('/pre_quiz/0');
                      },
                      child: const Text('Single Kanji N5 & N4'),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/pre_quiz/1');
                      },
                      child: const Text('Semua Kata'),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/pre_quiz/2');
                      },
                      child: const Text('Kata Sifat'),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/pre_quiz/3');
                      },
                      child: const Text('Kata Benda'),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/pre_quiz/4');
                      },
                      child: const Text('Kata Kerja'),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/pre_quiz/5');
                      },
                      child: const Text('Kata Sayur dan Buah'),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/pre_quiz/6');
                      },
                      child: const Text('Kata Hewan'),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/pre_quiz/7');
                      },
                      child: const Text('Kata Cuaca'),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/pre_quiz/8');
                      },
                      child: const Text('Kata Pekerjaan'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}