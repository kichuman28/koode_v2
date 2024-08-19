// Created by: Adwaith Jayasankar, Created at: 19-08-2024 16:09
// lib/widgets/recording_list_tile.dart
import 'package:flutter/material.dart';
import 'package:koode_v2/models/audio_recording.dart';

class RecordingListTile extends StatelessWidget {
  final AudioRecording recording;
  final int index;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const RecordingListTile({
    required this.recording,
    required this.index,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onLongPress,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(recording.name),
      subtitle: Text("${recording.date} - ${recording.duration}"),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: isSelected,
      trailing: isSelectionMode
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
    );
  }
}
