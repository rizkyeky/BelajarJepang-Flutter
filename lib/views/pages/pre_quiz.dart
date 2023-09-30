part of _view;

class PreQuizPage extends StatelessWidget {
  const PreQuizPage({super.key,
    required this.idx
  });

  final int idx;

  @override
  Widget build(BuildContext context) {
    int len = 5;
    bool useKanji = false;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StatefulValueBuilder<int>(
            initialValue: 5,
            builder: (context, stateValue, setValue) {
              return Column(
                children: [
                  LayoutBuilder(
                    builder: (context, box) {
                      final slider = Slider(
                        value: (stateValue ?? 0).toDouble(),
                        min: 5,
                        max: 100,
                        onChanged: (value) {
                          setValue(value.toInt());
                          len = value.toInt();
                        },
                      );
                      return box.maxWidth > 400 ? SizedBox(
                        width: 400,
                        child: slider,
                      ) : slider;
                    }
                  ),
                  const SizedBox(height: 16,),
                  Text('Quiz Length: $len'),
                ],
              );
            }
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Only Kanji'),
              StatefulValueBuilder<bool>(
                initialValue: useKanji,
                builder: (context, stateValue, setValue) {
                  return Checkbox(
                    value: stateValue,
                    onChanged: (value) {
                      setValue(value ?? false);
                      useKanji = value ?? false;
                    },
                  );
                }
              )
            ],
          ),
          const SizedBox(height: 16,),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Routemaster.of(context).push('/quiz/$idx',
                  queryParameters: {
                    'len': len.toString(),
                    'onlyKanji': useKanji ? 'true' : 'false'
                  }
                );
              },
              child: const Text('Start Quiz'),
            ),
          ),
        ],
      ),
    );
  }
}