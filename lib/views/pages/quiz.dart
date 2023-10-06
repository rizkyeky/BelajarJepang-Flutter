part of _view;

class QuizPage extends StatelessWidget {
  const QuizPage({super.key,
    required this.quizType,
    required this.len,
    required this.onlyKanji
  });

  final QuizType quizType;
  final int len;
  final bool onlyKanji;

  @override
  Widget build(BuildContext context) {
    final quizController = context.read<QuizController>();
    int correctCount = 0;
    String? inputQuiz;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<KanjiModel>>(
        future: quizController.startQuiz(quizType, len, onlyKanji),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final kanjis = snapshot.data ?? [];
            if (kanjis.isNotEmpty) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 400,
                          child: Center(
                            child: Text(kanjis[correctCount].kanji,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: quizType == QuizType.satuKanji ? 240 
                                : kanjis[correctCount].kanji.length > 2 ? 90 : 120,
                                fontFamily: quizController.getRandomFontFamily(),
                                height: 0,
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        StatefulValueBuilder<bool>(
                          initialValue: false,
                          builder: (context, value, setValue) => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "$correctCount/$len",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(value == true ? kanjis[correctCount].romanji : '----',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 32
                                  )
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  iconSize: 32,
                                  onPressed: () {
                                    setValue(!(value ?? true));
                                  },
                                  icon: value == true 
                                    ? const Icon(Icons.visibility_off) 
                                    : const Icon(Icons.visibility)
                                ),
                              )
                            ],
                          )
                        ),
                        const SizedBox(height: 16,),
                        LayoutBuilder(
                          builder: (context, box) {
                            final field = TextField(
                              controller: TextEditingController(text: inputQuiz),
                              onChanged: (value) => inputQuiz = value,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            );
                            return box.maxWidth > 400 ? SizedBox(
                              width: 400,
                              child: field,
                            ) : field;
                          }
                        ),
                        const SizedBox(height: 16,),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              final artis = kanjis[correctCount].arti.toLowerCase().split('/');
                              final correct = artis.any((element) => element == inputQuiz);
                              if (correct) {
                                if (correctCount == kanjis.length-1) {
                                  showDialog(
                                    context: context, 
                                    builder: (context) => AlertDialog(
                                      title: const Text('Kamu telah menyelesaikan quiz!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            Routemaster.of(context).popUntil((route) => false);
                                          },
                                          child: const Text('Kembali'),
                                        )
                                      ]
                                    )
                                  );
                                } else {
                                  setState(() {
                                    correctCount++;
                                    inputQuiz = null;
                                  });
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    elevation: 0,
                                    backgroundColor: Colors.red.shade50,
                                    duration: const Duration(seconds: 1),
                                    content: const Text('Kamu salah',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red
                                      ),
                                    ),  
                                  )
                                );
                              }
                            },
                            child: const Icon(Icons.arrow_forward_outlined),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Center(
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 0,
                                  backgroundColor: Colors.cyan.shade50,
                                  content: Text(kanjis[correctCount].arti,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan
                                    ),
                                  ),  
                                  duration: const Duration(seconds: 1)
                                )
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.question_mark_rounded),
                          ),
                        )
                      ],
                    ),
                  );
                }
              );
            } else {
              return const Center(
                child: Text('Kosong'),
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