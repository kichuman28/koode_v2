import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Applying the gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Dark blue
              Color(0xFF0B666A), // Teal blue
              Color(0xFF071952),
            ],
          ),
        ),
        child: Column(
          children: [
            // Top 1/4th of the screen
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Teach your loved ones, through",
                      style: GoogleFonts.reemKufi(
                        textStyle: const TextStyle(
                          color: Color(0xFFDEFAF5),
                          fontSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Koode",
                      style: GoogleFonts.greatVibes(
                        textStyle: const TextStyle(
                          color: Color(0xFF97FEED),
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _buildButton(
                        context: context,
                        label: "Record",
                        color: const Color(0xFF35A29F),
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                    ),
                    const SizedBox(height: 27),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _buildButton(
                        context: context,
                        label: "Default Audios",
                        color: const Color(0xFF0B666A),
                        onTap: () {
                          Navigator.pushNamed(context, '/default-audios');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.reemKufi(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
