import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlphabetListPage extends StatelessWidget {
  const AlphabetListPage({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two tabs per row
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.5, // Adjusted aspect ratio for better fit
            ),
            itemCount: 26, // Number of alphabets
            itemBuilder: (context, index) {
              String alphabet = String.fromCharCode(65 + index);
              String icon = '$alphabet${String.fromCharCode(97 + index)}'; // Creates 'Aa', 'Bb', etc.
              return _buildAlphabetTab(
                context: context,
                icon: icon,
                color: const Color(0xFF35A29F), // You can vary the colors if needed
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/alphabet-detail',
                    arguments: icon,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAlphabetTab({
    required BuildContext context,
    required String icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            icon,
            style: GoogleFonts.reemKufi(
              textStyle: const TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
