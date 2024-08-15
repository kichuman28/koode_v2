// Created by: Adwaith Jayasankar, Created at: 15-08-2024 21:53
import 'package:flutter/material.dart';

class DefaultAudiosPage extends StatelessWidget {
  const DefaultAudiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Default Audios"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Alphabets"),
            onTap: () {
              Navigator.pushNamed(context, '/alphabet-list');
            },
          ),
          // Add more folders here if needed
        ],
      ),
    );
  }
}
