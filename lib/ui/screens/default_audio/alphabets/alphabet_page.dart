// Created by: Adwaith Jayasankar, Created at: 15-08-2024 21:54
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AlphabetDetailPage extends StatefulWidget {
  final String alphabet;
  const AlphabetDetailPage({super.key, required this.alphabet});

  @override
  State<AlphabetDetailPage> createState() => _AlphabetDetailPageState();
}

class _AlphabetDetailPageState extends State<AlphabetDetailPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAlphabetAudio() async {
    String lowercaseAlphabet = widget.alphabet.toLowerCase();
    try {
      await audioPlayer.setAsset('assets/audios/alphabets/$lowercaseAlphabet.mp3');
      audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: playAlphabetAudio,
        child: Center(
          child: Text(
            widget.alphabet,
            style: const TextStyle(fontSize: 200, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
