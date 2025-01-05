// Created by: Adwaith Jayasankar, Created at: 01-09-2024 23:11
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koode_v2/ui/screens/default_audio/numbers/numbers_page.dart';

class NumberListPage extends StatelessWidget {
  const NumberListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of numbers and their corresponding names
    final List<Map<String, String>> numbers = [
      {'number': '1', 'name': 'One'},
      {'number': '2', 'name': 'Two'},
      {'number': '3', 'name': 'Three'},
      {'number': '4', 'name': 'Four'},
      {'number': '5', 'name': 'Five'},
      {'number': '6', 'name': 'Six'},
      {'number': '7', 'name': 'Seven'},
      {'number': '8', 'name': 'Eight'},
      {'number': '9', 'name': 'Nine'},
      {'number': '10', 'name': 'Ten'},
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
              childAspectRatio: 1.5, // Adjust aspect ratio if needed
            ),
            itemCount: numbers.length, // Number of numbers to display
            itemBuilder: (context, index) {
              String number = numbers[index]['number']!;
              String name = numbers[index]['name']!;
              return _buildNumberTab(
                context: context,
                number: number,
                name: name,
                color: const Color(0xFF35A29F), // Customize the color if needed
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NumberDetailPage(
                        number: number, // Pass the selected number
                        name: name, // Pass the corresponding name
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

  Widget _buildNumberTab({
    required BuildContext context,
    required String number,
    required String name,
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
                number,
                style: GoogleFonts.reemKufi(
                  textStyle: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                name,
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
