// Created by: Adwaith Jayasankar, Created at: 15-08-2024 22:52
import 'package:flutter/material.dart';
// Assume recordedFile data is fetched from local storage

class RecordingsListPage extends StatelessWidget {
  const RecordingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> recordings = [
      // Dummy data for the sake of this example
      {'name': 'Recording 1', 'date': '2024-08-15', 'duration': '00:30'},
      {'name': 'Recording 2', 'date': '2024-08-14', 'duration': '01:15'},
      // Real implementation should load actual data from local storage
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recordings"),
      ),
      body: ListView.builder(
        itemCount: recordings.length,
        itemBuilder: (context, index) {
          final recording = recordings[index];
          return ListTile(
            title: Text(recording['name']!),
            subtitle: Text("Date: ${recording['date']} - Duration: ${recording['duration']}"),
            onTap: () {
              // Implement playback of the selected recording
              // Playback code goes here.
            },
          );
        },
      ),
    );
  }
}
