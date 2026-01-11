import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController goalController = TextEditingController();

  String? _selectedRole;
  String? _selectedUsageReason;
  String? _selectedAmount;

  final _roles = const [
    'I use AI as a companion',
    'I\'m a student',
    'I\'m a working adult',
    'I\'m an entrepreneur',
    'I\'m an artist',
    'Other',
  ];

  final _usages = const [
    'I need to think more critically',
    'I need to think more creatively',
    'It is hurting my relationships',
  ];

  final _amounts = const [
    '10+ times a day',
    '2-10 times a day',
    '1-7 times a week',
    '< 1 time a week',
  ];

  @override
  void dispose() {
    nameController.dispose();
    goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding questions')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Name
          const SizedBox(height: 24),
          const Text(
            'What should we call you?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Your name',
              hintText: 'E.g. Sam',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
          ),

          // Usage Reason
          const SizedBox(height: 24),
          const Text(
            'Why do you want to control your AI usage?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._usages.map(
            (use) => RadioListTile<String>(
              title: Text(use),
              value: use,
              groupValue: _selectedUsageReason,
              onChanged: (value) {
                setState(() => _selectedUsageReason = value);
              },
            ),
          ),

          // Role
          const SizedBox(height: 24),
          const Text(
            'What best describes you?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._roles.map(
            (role) => RadioListTile<String>(
              title: Text(role),
              value: role,
              groupValue: _selectedRole,
              onChanged: (value) {
                setState(() => _selectedRole = value);
              },
            ),
          ),

          // Amount of AI
          const SizedBox(height: 24),
          const Text(
            'On average, how much do you use AI?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._amounts.map(
            (amount) => RadioListTile<String>(
              title: Text(amount),
              value: amount,
              groupValue: _selectedAmount,
              onChanged: (value) {
                setState(() => _selectedAmount = value);
              },
            ),
          ),

          // Goal of AI usage
          const SizedBox(height: 24),
          const Text(
            'How much do you want to use AI each day?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: goalController,
            decoration: const InputDecoration(
              labelText: 'Times per day (1-15)',
              hintText: 'E.g. 5',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),

          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              final goal = goalController.text.trim();
              debugPrint('Name: $name');
              debugPrint('Why control: $_selectedUsageReason');
              debugPrint('Role: $_selectedRole');
              debugPrint('Current usage: $_selectedAmount');
              debugPrint('Daily goal: $goal');
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
