// Created by: Adwaith Jayasankar, Created at: 01-09-2024 21:30
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koode_v2/ui/screens/default_audio/animals/animal_page.dart';

class AnimalsListPage extends StatelessWidget {
  const AnimalsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> animals = [
      {'icon': '🐶', 'name': 'Dog'},
      {'icon': '🐱', 'name': 'Cat'},
      {'icon': '🐮', 'name': 'Cow'},
      {'icon': '🐔', 'name': 'Chicken'},
      {'icon': '🐭', 'name': 'Mouse'},
      {'icon': '🐸', 'name': 'Frog'},
      {'icon': '🐵', 'name': 'Monkey'},
      {'icon': '🐘', 'name': 'Elephant'},
      {'icon': '🦁', 'name': 'Lion'},
      {'icon': '🐻', 'name': 'Bear'},
    ];

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
            itemCount: animals.length, // Number of animals
            itemBuilder: (context, index) {
              return _buildAnimalTab(
                context: context,
                icon: animals[index]['icon']!,
                label: animals[index]['name']!,
                color: const Color(0xFF35A29F), // You can vary the colors if needed
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimalDetailPage(
                        icon: animals[index]['icon']!,
                        name: animals[index]['name']!,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimalTab({
    required BuildContext context,
    required String icon,
    required String label,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                icon,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                label,
                style: GoogleFonts.reemKufi(
                  textStyle: const TextStyle(
                    fontSize: 20,
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
