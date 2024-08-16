// Created by: Adwaith Jayasankar, Created at: 16-08-2024 23:12
import 'package:hive/hive.dart';

part 'audio_recording.g.dart'; // Hive generates this file

@HiveType(typeId: 0)
class AudioRecording {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String path;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String duration;

  AudioRecording({
    required this.name,
    required this.path,
    required this.date,
    required this.duration,
  });
}
