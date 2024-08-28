import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultAudiosPage extends StatelessWidget {
  const DefaultAudiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF071952), Color(0xFF0B666A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              _buildCategoryTab(
                context: context,
                icon: "Aa",
                label: "Alphabets",
                color: const Color(0xFF35A29F),
                onTap: () {
                  Navigator.pushNamed(context, '/alphabet-list');
                },
              ),
              _buildCategoryTab(
                context: context,
                icon: "🐾", // Example icon for Animals
                label: "Animals",
                color: const Color(0xFF35A29F),
                onTap: () {
                  // Navigator.pushNamed(context, '/animals-list');
                },
              ),
              _buildCategoryTab(
                context: context,
                icon: "123",
                label: "Numbers",
                color: const Color(0xFF0B666A),
                onTap: () {
                  // Navigator.pushNamed(context, '/numbers-list');
                },
              ),
              _buildCategoryTab(
                context: context,
                icon: "👨‍👩‍👧‍👦", // Example icon for Relationships
                label: "Relationships",
                color: const Color(0xFF0B666A),
                onTap: () {
                  // Navigator.pushNamed(context, '/relationships-list');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTab({
    required BuildContext context,
    required String icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                icon,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 56,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                label,
                style: GoogleFonts.reemKufi(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
