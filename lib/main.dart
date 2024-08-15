import 'package:flutter/material.dart';
import 'package:koode_v2/alphabet_list.dart';
import 'package:koode_v2/alphabet_page.dart';
import 'package:koode_v2/default_audio.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/default-audios': (context) => const DefaultAudiosPage(),
        '/alphabet-list': (context) => const AlphabetListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/alphabet-detail') {
          final String alphabet = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => AlphabetDetailPage(alphabet: alphabet),
          );
        }
        return null;
      },
    );
  }
}
