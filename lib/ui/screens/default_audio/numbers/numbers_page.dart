// Created by: Adwaith Jayasankar, Created at: 01-09-2024 23:11
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberDetailPage extends StatefulWidget {
  final String number;
  final String name;

  const NumberDetailPage({super.key, required this.number, required this.name});

  @override
  State<NumberDetailPage> createState() => _NumberDetailPageState();
}

class _NumberDetailPageState extends State<NumberDetailPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playNumberAudio() async {
    // Convert number name to lowercase for file lookup
    String lowercaseName = widget.name.toLowerCase();
    try {
      await audioPlayer.setAsset('assets/audios/numbers/$lowercaseName.mp3');
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
          onTap: playNumberAudio,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.number,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 200,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.name,
                  style: GoogleFonts.abrilFatface(
                    textStyle: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
