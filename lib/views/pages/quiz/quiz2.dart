part of _view;

class Quiz2Page extends StatelessWidget {
  const Quiz2Page({super.key,
    required this.len,
    required this.lenKatakana,
    this.withAdd=false,
    this.withLong=false
  });

  final int len;
  final int lenKatakana;
  final bool withAdd;
  final bool withLong;
  
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
      body: StatefulBuilder(
        builder: (context, setState) {
          final (katakana, romanji) = quizController.generateRandomKatakanaWord(lenKatakana, withAdd, withLong);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: Center(
                    child: Text(katakana,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: katakana.length > 2 ? 80 : 100,
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
                      const Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: 200,
                        )
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: 200,
                        )
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
                      final correct = quizController.checkKatakana(katakana, inputQuiz ?? '');
                      if (correct) {
                        if (correctCount == len-1) {
                          Navigator.pop(context);
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
                          content: Text(romanji,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan
                            ),
                          ),  
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
      ),
    );
  }
}