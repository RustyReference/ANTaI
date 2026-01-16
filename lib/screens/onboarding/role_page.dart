import 'package:flutter/material.dart';

class RolePage extends StatelessWidget {
  final List<String> roles;
  final String? selected;
  final ValueChanged<String?> onChanged;

  const RolePage({
    super.key,
    required this.roles,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          'What best describes you?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RadioGroup<String>(
          groupValue: selected,
          onChanged: onChanged,
          child: Column(
            children: [
              for (final role in roles)
                RadioListTile<String>(
                  title: Text(role),
                  value: role,
                ),
            ],
          ),
        ),
      ],
    );
  }
}