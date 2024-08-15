import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();
  String? recordingPath;
  bool isRecording = false;
  int _recordingDuration = 0;
  Timer? _timer;

  @override
  void dispose() {
    audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> toggleRecording() async {
    if (isRecording) {
      String? filePath = await audioRecorder.stop();
      if (filePath != null) {
        _timer?.cancel();
        setState(() {
          isRecording = false;
          recordingPath = filePath;
        });
        _showSaveDialog();
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
        final String filePath = p.join(appDocumentsDir.path, "recording_temp.wav");
        await audioRecorder.start(
          const RecordConfig(),
          path: filePath,
        );
        setState(() {
          isRecording = true;
          recordingPath = null;
          _recordingDuration = 0;
        });
        _startTimer();
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration++;
      });
    });
  }

  Future<void> _showSaveDialog() async {
    final TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Save Recording"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Enter a name for your recording"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                String name = nameController.text;
                if (name.isNotEmpty) {
                  await _saveRecording(name);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveRecording(String name) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final String newFilePath = p.join(appDocumentsDir.path, "$name.wav");
    final file = File(recordingPath!);
    await file.rename(newFilePath);
    final recordedFile = {
      'name': name,
      'path': newFilePath,
      'date': DateTime.now().toString(),
      'duration': _formatDuration(_recordingDuration),
    };
    // Save `recordedFile` to local storage for future use
    // Code to save to local storage goes here.
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: toggleRecording,
              child: Icon(
                isRecording ? Icons.stop_circle : Icons.mic,
                size: 150,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (isRecording)
              Text(
                "Recording: ${_formatDuration(_recordingDuration)}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: recordingPath != null ? playRecording : null,
              child: const Text("Play Recording"),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/recordings-list');
                },
                icon: const Icon(Icons.library_music),
                tooltip: 'My Recordings',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
