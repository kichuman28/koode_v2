// Created by: Adwaith Jayasankar, Created at: 15-08-2024 21:54
import 'package:flutter/material.dart';

class AlphabetListPage extends StatelessWidget {
  const AlphabetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alphabets"),
      ),
      body: ListView.builder(
        itemCount: 26,
        itemBuilder: (context, index) {
          String alphabet = String.fromCharCode(65 + index);
          return ListTile(
            title: Text(alphabet),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/alphabet-detail',
                arguments: alphabet,
              );
            },
          );
        },
      ),
    );
  }
}
