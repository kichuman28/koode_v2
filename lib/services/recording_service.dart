// Created by: Adwaith Jayasankar, Created at: 16-08-2024 22:42
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:hive/hive.dart';
import '../models/audio_recording.dart';

class RecordingService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? recordingPath;
  bool isRecording = false;

  Future<bool> startRecording() async {
    if (await _audioRecorder.hasPermission()) {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      final String filePath = p.join(appDocumentsDir.path, "recording_temp.wav");
      await _audioRecorder.start(
        const RecordConfig(),
        path: filePath,
      );
      recordingPath = null;
      isRecording = true;
      return true;
    }
    return false;
  }

  Future<String?> stopRecording() async {
    String? filePath = await _audioRecorder.stop();
    isRecording = false;
    recordingPath = filePath;
    return filePath;
  }

  Future<void> saveRecording(String name, String filePath, int duration) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final String newFilePath = p.join(appDocumentsDir.path, "$name.wav");
    final file = File(filePath);
    await file.rename(newFilePath);

    final recording = AudioRecording(
      name: name,
      path: newFilePath,
      date: DateTime.now(),
      duration: _formatDuration(duration),
    );

    // Save the recording details to Hive box
    final box = Hive.box<AudioRecording>('recordings');
    box.add(recording);
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  Future<void> playRecording() async {
    if (recordingPath != null) {
      await _audioPlayer.setFilePath(recordingPath!);
      _audioPlayer.play();
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
