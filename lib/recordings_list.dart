// Created by: Adwaith Jayasankar, Created at: 15-08-2024 22:52
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/audio_recording.dart';
import 'package:just_audio/just_audio.dart';

class RecordingsListPage extends StatelessWidget {
  const RecordingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<AudioRecording> recordingsBox = Hive.box<AudioRecording>('recordings');
    final AudioPlayer audioPlayer = AudioPlayer();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recordings"),
      ),
      body: _buildRecordingsList(recordingsBox, audioPlayer),
    );
  }

  Widget _buildRecordingsList(Box<AudioRecording> recordingsBox, AudioPlayer audioPlayer) {
    return ValueListenableBuilder(
      valueListenable: recordingsBox.listenable(),
      builder: (context, Box<AudioRecording> box, _) {
        if (box.values.isEmpty) {
          return const Center(child: Text("No recordings available"));
        } else {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final recording = box.getAt(index);
              return ListTile(
                title: Text(recording!.name),
                subtitle: Text("${recording.date} - ${recording.duration}"),
                onTap: () async {
                  await audioPlayer.setFilePath(recording.path);
                  audioPlayer.play();
                },
              );
            },
          );
        }
      },
    );
  }
}
