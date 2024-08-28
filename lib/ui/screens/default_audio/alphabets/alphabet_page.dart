import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // Extract the first character in lowercase
    String lowercaseAlphabet = widget.alphabet[0].toLowerCase();
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF071952), Color(0xFF0B666A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GestureDetector(
          onTap: playAlphabetAudio,
          child: Center(
            child: Text(
              widget.alphabet,
              style: GoogleFonts.abrilFatface(
                textStyle: const TextStyle(
                  fontSize: 200,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Font color matches the overall theme
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
