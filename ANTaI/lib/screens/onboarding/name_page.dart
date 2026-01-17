import 'package:flutter/material.dart';

class NamePage extends StatelessWidget {
  final TextEditingController controller;
  const NamePage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'What should we call you?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Your name',
            hintText: 'E.g. Sam',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.name,
        ),
      ],
    );
  }
}