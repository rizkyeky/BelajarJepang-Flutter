part of _view;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build home page');
    final controller = PageController();
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
                            Routemaster.of(context).push('/pre_quiz/0');
                          },
                          child: const Text('Single Kanji'),
                        ),
                        const SizedBox(height: 16,),
                        ElevatedButton(
                          onPressed: () {
                            Routemaster.of(context).push('/pre_quiz/9');
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
          // Container(
          //   color: Colors.red,
          // ),
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
                            // Routemaster.of(context).push('/pre_quiz/0');
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => const BookPage())
                            );
                          },
                          child: const Text('Single Kanji'),
                        ),
                        const SizedBox(height: 16,),
                        ElevatedButton(
                          onPressed: () {
                            // Routemaster.of(context).push('/pre_quiz/9');
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => const KosakataPage())
                            );
                          },
                          child: const Text('Kosakata'),
                        ),
                        const SizedBox(height: 16,),
                        ElevatedButton(
                          onPressed: () {
                            // Routemaster.of(context).push('/pre_quiz/9');
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => const BookKerjaPage())
                            );
                          },
                          child: const Text('Kata Kerja'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
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
                label: 'Home'
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.search),
              //   label: 'Search'
              // ),
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