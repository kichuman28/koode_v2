// Created by: Adwaith Jayasankar, Created at: 02-09-2024 00:44
// Created by: Adwaith Jayasankar, Created at: 02-09-2024 01:00
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

class RelationshipDetailPage extends StatefulWidget {
  final String icon;
  final String name;

  const RelationshipDetailPage({super.key, required this.icon, required this.name});

  @override
  State<RelationshipDetailPage> createState() => _RelationshipDetailPageState();
}

class _RelationshipDetailPageState extends State<RelationshipDetailPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playRelationshipAudio() async {
    // Convert relationship name to lowercase for file lookup
    String lowercaseName = widget.name.toLowerCase();
    try {
      await audioPlayer.setAsset('assets/audios/relationships/$lowercaseName.mp3');
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
          onTap: playRelationshipAudio,
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
