part of _view;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Setting'),
                onTap: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const SettingPage())
                  );
                }
              )
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: PageView(
        controller: controller,
        children: [
          LayoutBuilder(
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
                              MaterialPageRoute(
                                builder: (context) => const PreQuizPage(type: QuizType.singleKanji)
                              )
                            );
                          },
                          child: const Text('Single Kanji'),
                        ),
                        const SizedBox(height: 16,),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) => const PreQuizPage(type: QuizType.multipleKanji)
                              )
                            );
                          },
                          child: const Text('Multiple Kanji'),
                        ),
                        const SizedBox(height: 16,),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) => const PreQuizPage(type: QuizType.katakana)
                              )
                            );
                          },
                          child: const Text('Katakana'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
          const BookPage()
        ],
      ),
      bottomNavigationBar: StatefulValueBuilder<int>(
        initialValue: 0,
        builder: (context, stateValue, setValue) {
          return BottomNavigationBar(
            currentIndex: stateValue ?? 0,
            onTap: (value) {
              controller.animateToPage(value, 
                duration: const Duration(milliseconds: 320), 
                curve: Curves.easeOut,
              );
              if (stateValue != value) {
                setValue(value);
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon:  Icon(Icons.home),
                label: 'Quiz'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: 'Book'
              )
            ]
          );
        }
      ),
    );
  }
}