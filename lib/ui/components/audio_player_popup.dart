//In the future planning to make an entire screen for playing each audio rather than
//a popup, like dolby app.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:koode_v2/models/audio_recording.dart';

class PlayerDialog extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final AudioRecording recording;

  const PlayerDialog({
    required this.audioPlayer,
    required this.recording,
    super.key,
  });

  @override
  PlayerDialogState createState() => PlayerDialogState();
}

class PlayerDialogState extends State<PlayerDialog> {
  late Duration _currentPosition;
  late Duration _totalDuration;
  late bool _isPlaying;
  late StreamSubscription<Duration> _positionSubscription;
  late StreamSubscription<PlayerState> _playerStateSubscription;

  @override
  void initState() {
    super.initState();
    _currentPosition = Duration.zero;
    _totalDuration = widget.audioPlayer.duration ?? Duration.zero;
    _isPlaying = widget.audioPlayer.playing;

    _positionSubscription = widget.audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    _playerStateSubscription = widget.audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });

    widget.audioPlayer.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          _totalDuration = duration ?? Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _playerStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.recording.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          _buildPlayerControls(context),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.audioPlayer.stop();
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerControls(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          min: 0.0,
          max: _totalDuration.inMilliseconds.toDouble(),
          value: _currentPosition.inMilliseconds.clamp(0, _totalDuration.inMilliseconds).toDouble(),
          onChanged: (value) async {
            final position = Duration(milliseconds: value.toInt());
            await widget.audioPlayer.seek(position);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (_isPlaying) {
                  widget.audioPlayer.pause();
                } else {
                  widget.audioPlayer.play();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () {
                widget.audioPlayer.stop();
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_currentPosition)),
              Text(_formatDuration(_totalDuration - _currentPosition)),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
