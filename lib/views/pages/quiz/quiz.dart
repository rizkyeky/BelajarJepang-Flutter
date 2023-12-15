part of _view;

class QuizPage extends StatelessWidget {
  const QuizPage({super.key,
    required this.len,
    required this.type,
  });

  final int len;
  final QuizType type;

  @override
  Widget build(BuildContext context) {
    final quizController = context.read<QuizController>();
    int correctCount = 0;
    String? inputQuiz;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: FutureBuilder<List<KanjiModel>>(
        future: quizController.startQuiz(len, type) ,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: switch (type) {
                            QuizType.singleKanji => 300,
                            _ => null,
                          },
                          height: switch (type) {
                            QuizType.multipleKanji => 300,
                            _ => null,
                          },
                          child: Center(
                            child: Text(kanjis[correctCount].kana,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: switch (type) {
                                  QuizType.singleKanji => 240,
                                  QuizType.multipleKanji => switch(kanjis[correctCount].kana.length) {
                                    > 3 => 80,
                                    > 2 => 90,
                                    _ => 100
                                  } ,
                                  _ => 160,
                                },
                                fontFamily: quizController.getRandomFontFamily(),
                                height: 0,
                              )
                            ),
                          ),
                        ),
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(value == true ? kanjis[correctCount].romanji.join('/') : '----',
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
                              final artis = kanjis[correctCount].arti.map((e) => e.toLowerCase());
                              final correct = artis.any((element) => element == inputQuiz?.toLowerCase());
                              if (correct) {
                                if (correctCount == kanjis.length-1) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Future.delayed(const Duration(milliseconds: 400)).whenComplete(() {
                                    showDialog(
                                      context: context, 
                                      builder: (context) => AlertDialog(
                                        title: const Text('Kamu telah menyelesaikan quiz!'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {                                              
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Kembali'),
                                          )
                                        ]
                                      )
                                    );
                                  });
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
                                  content: Text(kanjis[correctCount].arti.join(', '),
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