import 'package:archieve_idea/data/idea_info.dart';
import 'package:archieve_idea/screen/detail_screen.dart';
import 'package:flutter/material.dart';

import 'screen/edit_screen.dart';
import 'screen/main_screen.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archive Idea',
      debugShowCheckedModeBanner: false,
      // 디버그 라벨 제거
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MainScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          // 1. 아이디어 기록값을 넘길 수 없다면 생성 시나리오
          // 2. 아이디어 기록값을 넘길 수 있다면 수정 시나리오
          final IdeaInfo? ideaInfo = settings.arguments as IdeaInfo?;
          return MaterialPageRoute(
            builder: (context) {
              return EditScreen();
            },
          );
        } else if (settings.name == '/detail') {
          final IdeaInfo? ideaInfo = settings.arguments as IdeaInfo?;
          return MaterialPageRoute(builder: (context) {
            return DetailScreen(ideaInfo: ideaInfo);
          });
        }
      },
    );
  }
}
