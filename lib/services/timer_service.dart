// Created by: Adwaith Jayasankar, Created at: 16-08-2024 22:42
import 'dart:async';
import 'dart:ui';

class TimerService {
  int recordingDuration = 0;
  Timer? _timer;

  void startTimer(VoidCallback callback) {
    // Reset the duration before starting the timer
    recordingDuration = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      recordingDuration++;
      callback();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  String formatDuration() {
    final minutes = (recordingDuration ~/ 60).toString().padLeft(2, '0');
    final secs = (recordingDuration % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void dispose() {
    _timer?.cancel();
  }
}
