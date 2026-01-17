import 'package:flutter/material.dart';

class AmountPage extends StatelessWidget {
  final List<String> amounts;
  final String? selected;
  final ValueChanged<String?> onChanged;

  const AmountPage({
    super.key,
    required this.amounts,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          'On average, how much do you use AI?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...amounts.map(
          (amount) => RadioListTile<String>(
            title: Text(amount),
            value: amount,
            groupValue: selected,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}