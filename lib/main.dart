import 'package:flutter/material.dart';
import 'package:koode_v2/alphabet_list.dart';
import 'package:koode_v2/alphabet_page.dart';
import 'package:koode_v2/default_audio.dart';
import 'package:koode_v2/recordings_list.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'home_page.dart';
import 'models/audio_recording.dart';

void main() async {
  // Ensure that Flutter is fully initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open the box
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register the adapter for AudioRecording
  Hive.registerAdapter(AudioRecordingAdapter());

  // Open the box for recordings
  await Hive.openBox<AudioRecording>('recordings');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Close Hive when the app is disposed of
    Hive.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
        '/recordings-list': (context) => const RecordingsListPage(),
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
