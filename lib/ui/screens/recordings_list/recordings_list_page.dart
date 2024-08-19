// lib/pages/recordings_list_page.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:koode_v2/models/audio_recording.dart';
import 'package:koode_v2/services/recording_functions.dart';
import 'package:koode_v2/ui/components/recording_list_tile.dart';

class RecordingsListPage extends StatefulWidget {
  const RecordingsListPage({super.key});

  @override
  RecordingsListPageState createState() => RecordingsListPageState();
}

class RecordingsListPageState extends State<RecordingsListPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isSelectionMode = false;
  final Set<int> _selectedIndices = {};

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Box<AudioRecording> recordingsBox = Hive.box<AudioRecording>('recordings');

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recordings"),
        actions: _isSelectionMode
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteSelectedRecordings(
                    selectedIndices: _selectedIndices,
                    recordingsBox: recordingsBox,
                    onDeleteComplete: () {
                      setState(() {
                        _isSelectionMode = false;
                        _selectedIndices.clear();
                      });
                    },
                  ),
                ),
              ]
            : null,
      ),
      body: _buildRecordingsList(recordingsBox),
    );
  }

  Widget _buildRecordingsList(Box<AudioRecording> recordingsBox) {
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
              return RecordingListTile(
                recording: recording!,
                index: index,
                isSelected: _selectedIndices.contains(index),
                isSelectionMode: _isSelectionMode,
                onLongPress: () {
                  setState(() {
                    _isSelectionMode = true;
                    _selectedIndices.add(index);
                  });
                },
                onTap: () {
                  if (_isSelectionMode) {
                    setState(() {
                      if (_selectedIndices.contains(index)) {
                        _selectedIndices.remove(index);
                        if (_selectedIndices.isEmpty) {
                          _isSelectionMode = false;
                        }
                      } else {
                        _selectedIndices.add(index);
                      }
                    });
                  } else {
                    playRecording(
                      context: context,
                      audioPlayer: _audioPlayer,
                      recording: recording,
                    );
                  }
                },
                onEdit: () => renameRecording(
                  context: context, // Pass the context here
                  index: index,
                  recordingsBox: recordingsBox,
                ),
                onDelete: () => deleteRecording(
                  index: index,
                  recordingsBox: recordingsBox,
                ),
              );
            },
          );
        }
      },
    );
  }
}
