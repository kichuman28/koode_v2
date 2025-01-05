// Created by: Adwaith Jayasankar, Created at: 01-09-2024 21:57
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimalDetailPage extends StatefulWidget {
  final String icon;
  final String name;

  const AnimalDetailPage({super.key, required this.icon, required this.name});

  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAnimalAudio() async {
    // Convert animal name to lowercase for file lookup
    String lowercaseName = widget.name.toLowerCase();
    try {
      await audioPlayer.setAsset('assets/audios/animals/$lowercaseName.mp3');
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
          onTap: playAnimalAudio,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.icon,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 200,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Font color matches the overall theme
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
                      color: Colors.white, // Font color matches the overall theme
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
