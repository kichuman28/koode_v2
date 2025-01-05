// Created by: Adwaith Jayasankar, Created at: 02-09-2024 00:37
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koode_v2/ui/screens/default_audio/relationships/relationships_page.dart';

class RelationshipsListPage extends StatelessWidget {
  const RelationshipsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> relationships = [
      {'icon': '👨', 'label': 'Father'},
      {'icon': '👩', 'label': 'Mother'},
      {'icon': '👦', 'label': 'Son'},
      {'icon': '👧', 'label': 'Daughter'},
      {'icon': '👴', 'label': 'Grandfather'},
      {'icon': '👵', 'label': 'Grandmother'},
      {'icon': '👨‍👦', 'label': 'Brother'},
      {'icon': '👩‍👧', 'label': 'Sister'},
      // Add more relationships as needed
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
            itemCount: relationships.length,
            itemBuilder: (context, index) {
              final relationship = relationships[index];
              return _buildRelationshipTab(
                context: context,
                icon: relationship['icon']!,
                label: relationship['label']!,
                color: const Color(0xFF35A29F),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RelationshipDetailPage(
                        icon: relationship['icon']!,
                        name: relationship['label']!,
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

  Widget _buildRelationshipTab({
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
                style: GoogleFonts.reemKufi(
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
