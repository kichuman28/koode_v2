import 'package:flutter/material.dart';
import 'package:koode_v2/recording_service.dart';
import 'package:koode_v2/save_dialog.dart';
import 'package:koode_v2/timer_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RecordingService _recordingService = RecordingService();
  final TimerService _timerService = TimerService();

  @override
  void dispose() {
    _recordingService.dispose();
    _timerService.dispose();
    super.dispose();
  }

  void _toggleRecording() async {
    if (_recordingService.isRecording) {
      String? filePath = await _recordingService.stopRecording();
      if (filePath != null) {
        _timerService.stopTimer();
        _showSaveDialog(filePath);
      }
    } else {
      if (await _recordingService.startRecording()) {
        _timerService.startTimer(() {
          setState(() {});
        });
      }
    }
    setState(() {});
  }

  void _showSaveDialog(String filePath) {
    showDialog(
      context: context,
      builder: (context) => SaveDialog(
        onSave: (name) async {
          await _recordingService.saveRecording(name, filePath, _timerService.recordingDuration);
          Navigator.of(context).pop();
        },
      ),
    );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _toggleRecording,
              child: Icon(
                _recordingService.isRecording ? Icons.stop_circle : Icons.mic,
                size: 150,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (_recordingService.isRecording)
              Text(
                "Recording: ${_timerService.formatDuration()}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _recordingService.recordingPath != null ? _recordingService.playRecording : null,
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
