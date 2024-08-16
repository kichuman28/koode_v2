// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_recording.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioRecordingAdapter extends TypeAdapter<AudioRecording> {
  @override
  final int typeId = 0;

  @override
  AudioRecording read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioRecording(
      name: fields[0] as String,
      path: fields[1] as String,
      date: fields[2] as DateTime,
      duration: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AudioRecording obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioRecordingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
