
import 'package:belajar_jepang/controllers/_controller.dart';
import 'package:belajar_jepang/providers/_provider.dart';
import 'package:belajar_jepang/services/_services.dart';
import 'package:belajar_jepang/views/_view.dart';
// import 'package:belajar_jepang/router.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:routemaster/routemaster.dart';

Future<void> main() async {

  final binding = WidgetsFlutterBinding.ensureInitialized();

  final HiveService hiveService = HiveService();
  await hiveService.init();
  final brightnessBox = await hiveService.brightnessBox();
  // final localizationBox = await hiveService.localizationBox();

  final brightnessProvider = BrightnessProvider(
    platformBrightness: binding.platformDispatcher.platformBrightness,
    box: brightnessBox,
  );
  await brightnessProvider.loadBrightnessFromLocal();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => brightnessProvider
        ),
        Provider(
          create: (context) => QuizController(),
        ),
        Provider(
          create: (context) => BookController(),
        ),
      ],
      child: const MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    final brightnessProvider = context.watch<BrightnessProvider>();
  
    // print('build main app');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: brightnessProvider.brightnessForTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: brightnessProvider.brightnessForTheme ?? Brightness.light,
        )
      ),
      home: const HomePage(),
    );
  }
}
