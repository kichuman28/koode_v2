import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();
  String? recordingPath;
  bool isRecording = false, isPlaying = false;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> toggleRecording() async {
    if (isRecording) {
      String? filePath = await audioRecorder.stop();
      if (filePath != null) {
        setState(() {
          isRecording = false;
          recordingPath = filePath;
        });
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
        final String filePath = p.join(appDocumentsDir.path, "recording.wav");
        await audioRecorder.start(
          const RecordConfig(),
          path: filePath,
        );
        setState(() {
          isRecording = true;
          recordingPath = null;
        });
      }
    }
  }

  Future<void> playRecording() async {
    if (recordingPath != null) {
      await audioPlayer.setFilePath(recordingPath!);
      audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Record and Play"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/default-audios');
            },
            icon: const Icon(Icons.library_music),
            tooltip: 'Default Audios',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleRecording,
        child: Icon(isRecording ? Icons.stop : Icons.mic),
      ),
      body: Center(
        child: recordingPath != null
            ? ElevatedButton(
                onPressed: playRecording,
                child: const Text("Play Recording"),
              )
            : const Text("No Recording Found"),
      ),
    );
  }
}
