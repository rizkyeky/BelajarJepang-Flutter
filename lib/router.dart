import 'package:belajar_jepang/controllers/_controller.dart';
import 'package:belajar_jepang/views/_view.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

RouteMap routeMap(BuildContext context) {
  return RouteMap(
    onUnknownRoute: (path) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
        child: HomePage()
      ),
      '/setting': (route) => const MaterialPage(
        child: SettingPage()
      ),
      '/pre_quiz/:idx': (route) => MaterialPage(
        child: PreQuizPage(
          idx: int.tryParse(route.pathParameters['idx'] ?? '') ?? 0
        )
      ),
      '/quiz/:idx': (route) => MaterialPage(
        child: QuizPage(
          quizType: QuizType.values[
            int.tryParse(route.pathParameters['idx'] ?? '') ?? 0
          ],
          len: int.tryParse(route.queryParameters['len'] ?? '')?.toInt() ?? 0,
          onlyKanji: (route.queryParameters['onlyKanji'] ?? '') == 'true',
        )
      ),
      '/quiz2/:idx': (route) => MaterialPage(
        child: Quiz2Page(
          len: int.tryParse(route.queryParameters['len'] ?? '')?.toInt() ?? 0,
          lenKatakana: int.tryParse(route.queryParameters['lenKatakana'] ?? '')?.toInt() ?? 0,
          withAdd: (route.queryParameters['withAdd'] ?? '') == 'true',
          withLong: (route.queryParameters['withLong'] ?? '') == 'true',
        )
      ),
    }
  );
}
