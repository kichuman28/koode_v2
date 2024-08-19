// lib/utils/recording_functions.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:koode_v2/models/audio_recording.dart';
import 'package:koode_v2/ui/components/player_dialog.dart';

Future<void> playRecording({
  required BuildContext context,
  required AudioPlayer audioPlayer,
  required AudioRecording recording,
}) async {
  await audioPlayer.setFilePath(recording.path);

  if (!context.mounted) return;

  showDialog(
    context: context,
    builder: (context) {
      return PlayerDialog(
        audioPlayer: audioPlayer,
        recording: recording,
      );
    },
  );

  audioPlayer.play();
}

Future<void> renameRecording({
  required BuildContext context,
  required int index,
  required Box<AudioRecording> recordingsBox,
}) async {
  final recording = recordingsBox.getAt(index);
  final TextEditingController controller = TextEditingController(text: recording?.name);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Rename Recording'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'New name'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                recordingsBox.putAt(
                  index,
                  AudioRecording(
                    name: controller.text,
                    date: recording!.date,
                    duration: recording.duration,
                    path: recording.path,
                  ),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

Future<void> deleteRecording({
  required int index,
  required Box<AudioRecording> recordingsBox,
}) async {
  recordingsBox.deleteAt(index);
}

Future<void> deleteSelectedRecordings({
  required Set<int> selectedIndices,
  required Box<AudioRecording> recordingsBox,
  required void Function() onDeleteComplete,
}) async {
  final sortedIndices = selectedIndices.toList()..sort((a, b) => b.compareTo(a));

  for (var index in sortedIndices) {
    recordingsBox.deleteAt(index);
  }

  onDeleteComplete();
}
