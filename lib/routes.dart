import 'package:flutter/material.dart';
import 'package:koode_v2/ui/screens/default_audio/alphabets/alphabet_list.dart';
import 'package:koode_v2/ui/screens/default_audio/alphabets/alphabet_page.dart';
import 'package:koode_v2/ui/screens/default_audio/default_audio_list.dart';
import 'package:koode_v2/ui/screens/home_page.dart';
import 'package:koode_v2/ui/screens/recordings_list/recordings_list_page.dart';
import 'package:koode_v2/ui/screens/splash_screen.dart';
import 'package:koode_v2/ui/screens/welcome_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(), // SplashScreen route
    '/welcome': (context) => const WelcomePage(), // New WelcomePage route
    '/home': (context) => const HomePage(), // HomePage moved to '/home'
    '/default-audios': (context) => const DefaultAudiosPage(),
    '/alphabet-list': (context) => const AlphabetListPage(),
    '/recordings-list': (context) => const RecordingsListPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/alphabet-detail') {
      final String alphabet = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => AlphabetDetailPage(alphabet: alphabet),
      );
    }
    return null;
  }
}
