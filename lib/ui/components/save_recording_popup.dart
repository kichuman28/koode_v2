// Created by: Adwaith Jayasankar, Created at: 16-08-2024 22:47
import 'package:flutter/material.dart';

class SaveDialog extends StatelessWidget {
  final void Function(String) onSave;

  const SaveDialog({required this.onSave, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return AlertDialog(
      title: const Text("Save Recording"),
      content: TextField(
        controller: nameController,
        decoration: const InputDecoration(hintText: "Enter a name for your recording"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            String name = nameController.text;
            if (name.isNotEmpty) {
              onSave(name);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
