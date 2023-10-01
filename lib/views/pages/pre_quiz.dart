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
    final quizController = context.read<QuizController>();
    quizController.selectedFonts.addAll(quizController.fontFamilies);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<KanjiModel>>(
        future: quizController.selectKanji(QuizType.values[idx]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final kanjis = snapshot.data ?? [];
            return Column(
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
                              max: kanjis.length.toDouble(),
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
                const SizedBox(height: 16,),
                Center(
                  child: SizedBox(
                    width: 280,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Center(
                          child: Column(
                            children: [
                              for (final font in quizController.fontFamilies) Row(
                                children: [
                                  Checkbox(
                                    value: quizController.selectedFonts.contains(font),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value ?? false) {
                                          quizController.selectedFonts.add(font);
                                        } else {
                                          if (quizController.selectedFonts.length > 1) {
                                            quizController.selectedFonts.remove(font);
                                          }
                                        }
                                      });
                                    },
                                  ),
                                  Column(
                                    children: [
                                      Text(font,),
                                      SizedBox(
                                        width: 200,
                                        child: Text("四五六七八九十",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: font,
                                            fontSize: 28
                                          )
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ],
            );
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