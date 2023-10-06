part of _view;

class PreQuizPage extends StatelessWidget {
  const PreQuizPage({super.key,
    required this.idx
  });

  final int idx;

  @override
  Widget build(BuildContext context) {
    int lenQuiz = 5;
    int lenKatakana = 2;
    // bool useKanji = false;
    bool withAdd= false;
    bool withLong = false;
    final isKatakanaQuiz = idx == 9;
    final quizController = context.read<QuizController>();
    quizController.selectedFonts.add(quizController.fontFamilies[0]);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          if (!isKatakanaQuiz) FutureBuilder(
            future: quizController.selectKanji(QuizType.values[idx]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final kanjis = snapshot.data ?? [];
                return LayoutBuilder(
                  builder: (context, box) {
                    final slider = StatefulValueBuilder<int>(
                      initialValue: 5,
                      builder: (context, stateValue, setValue) {
                        return Column(
                          children: [
                            Slider(
                              value: (stateValue ?? 0).toDouble(),
                              min: 5,
                              max: kanjis.length.toDouble(),
                              onChanged: (value) {
                                setValue(value.toInt());
                                lenQuiz = value.toInt();
                              },
                            ),
                            Text('Quiz Length: $lenQuiz'),
                          ],
                        );
                      }
                    );
                    return box.maxWidth > 400 ? SizedBox(
                      width: 400,
                      child: slider,
                    ) : slider;
                  }
                );
              } else {
                return const CircularProgressIndicator();
              }
            } 
          ) else LayoutBuilder(
            builder: (context, box) {
              final slider = StatefulValueBuilder<int>(
                initialValue: 5,
                builder: (context, stateValue, setValue) {
                  return Column(
                    children: [
                      Slider(
                        value: (stateValue ?? 0).toDouble(),
                        min: 5,
                        max: 100,
                        onChanged: (value) {
                          setValue(value.toInt());
                          lenQuiz = value.toInt();
                        },
                      ),
                      Text('Quiz Length: $lenQuiz'),
                    ],
                  );
                }
              );
              return box.maxWidth > 400 ? SizedBox(
                width: 400,
                child: slider,
              ) : slider;
            }
          ),
          if (isKatakanaQuiz) StatefulValueBuilder<int>(
            initialValue: 2,
            builder: (context, stateValue, setValue) {
              return Column(
                children: [
                  LayoutBuilder(
                    builder: (context, box) {
                      final slider = Slider(
                        value: (stateValue ?? 0).toDouble(),
                        min: 2,
                        max: 10,
                        onChanged: (value) {
                          setValue(value.toInt());
                          lenKatakana = value.toInt();
                        },
                      );
                      return box.maxWidth > 400 ? SizedBox(
                        width: 400,
                        child: slider,
                      ) : slider;
                    }
                  ),
                  Text('Katakana Length: $lenKatakana'),
                ],
              );
            }
          ),
          const SizedBox(height: 8,),
          if (isKatakanaQuiz) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('With Additional'),
              StatefulValueBuilder<bool>(
                initialValue: withAdd,
                builder: (context, stateValue, setValue) {
                  return Checkbox(
                    value: stateValue,
                    onChanged: (value) {
                      setValue(value ?? false);
                      withAdd = value ?? false;
                    },
                  );
                }
              ),
              const Text('With Long'),
              StatefulValueBuilder<bool>(
                initialValue: withLong,
                builder: (context, stateValue, setValue) {
                  return Checkbox(
                    value: stateValue,
                    onChanged: (value) {
                      setValue(value ?? false);
                      withLong = value ?? false;
                    },
                  );
                }
              )
            ],
          ),
          const SizedBox(height: 8,),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)
                ),
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                builder: (context) => Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 280,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            for (final font in quizController.fontFamilies) Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(font,),
                                    SizedBox(
                                      width: 200,
                                      child: Center(
                                        child: Text("四五六七八九十",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: font,
                                            fontSize: 28
                                          )
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8,)
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      }
                    ),
                  ),
                )
              );
              // Scaffold.of(context)
              // .showBottomSheet<void>();
            },
            child: const Text('Select Font Style'),
          ),
          const SizedBox(height: 120,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (isKatakanaQuiz) {
                    Routemaster.of(context).push('/quiz2/$idx',
                      queryParameters: {
                        'len': lenQuiz.toString(),
                        'lenKatakana': lenKatakana.toString(),
                        'withAdd': withAdd ? 'true' : 'false',
                        'withLong': withLong ? 'true' : 'false',
                      }
                    );
                  } else {
                    Routemaster.of(context).push('/quiz/$idx',
                      queryParameters: {
                        'len': lenQuiz.toString(),
                      }
                    );
                  }
                },
                child: const Text('Start Quiz'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}