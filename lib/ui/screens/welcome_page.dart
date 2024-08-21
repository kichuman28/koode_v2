// Created by: Adwaith Jayasankar, Created at: 21-08-2024 12:22
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Koode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Go to Home Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/default-audios');
              },
              child: const Text('Go to Default Audios'),
            ),
          ],
        ),
      ),
    );
  }
}
