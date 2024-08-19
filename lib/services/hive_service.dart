// Created by: Adwaith Jayasankar, Created at: 19-08-2024 14:15
import 'package:hive_flutter/hive_flutter.dart';
import 'package:koode_v2/models/audio_recording.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> initHive() async {
    // Initialize Hive and open the box
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);

    // Register the adapter for AudioRecording
    Hive.registerAdapter(AudioRecordingAdapter());

    // Open the box for recordings
    await Hive.openBox<AudioRecording>('recordings');
  }

  static Future<void> closeHive() async {
    await Hive.close();
  }

  static Box<AudioRecording> getRecordingsBox() {
    return Hive.box<AudioRecording>('recordings');
  }
}
