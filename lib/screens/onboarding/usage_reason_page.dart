import 'package:flutter/material.dart';

class UsageReasonPage extends StatelessWidget {
  final List<String> usages;
  final String? selected;
  final ValueChanged<String?> onChanged;

  const UsageReasonPage({
    super.key,
    required this.usages,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        const Text(
          'Why do you want to control your AI usage?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...usages.map(
          (use) => RadioListTile<String>(
            title: Text(use),
            value: use,
            groupValue: selected,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}