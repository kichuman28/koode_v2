// Created by: Adwaith Jayasankar, Created at: 19-08-2024 14:19

import 'package:flutter/material.dart';
import 'package:koode_v2/ui/screens/default_audio/alphabets/alphabet_list.dart';
import 'package:koode_v2/ui/screens/default_audio/alphabets/alphabet_page.dart';
import 'package:koode_v2/ui/screens/default_audio/default_audio_list.dart';
import 'package:koode_v2/ui/screens/home_page.dart';
import 'package:koode_v2/ui/screens/recordings_list.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePage(),
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
