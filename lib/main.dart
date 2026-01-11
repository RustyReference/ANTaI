import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController goalController = TextEditingController();
  String? _selectedRole;
  String? _selectedUsage;
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

          const SizedBox(height: 24),
          const Text(
            'How do you use AI?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._usages.map(
            (use) => RadioListTile<String>(
              title: Text(use),
              value: use,
              groupValue: _selectedUsage,
              onChanged: (value) {
                setState(() => _selectedUsage = value);
              },
            ),
          ),

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

          const SizedBox(height: 24),
          const Text(
            'How often do you use AI?',
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
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number';
              }
              final n = int.tryParse(value);
              if (n == null) {
                return 'Enter a valid number';
              }
              if (n < 1 || n > 15) {
                return 'Enter a number between 1 and 15';
              }
              return null;
            },
          ),

          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              final goal = goalController.text.trim();
              debugPrint('Name: $name');
              debugPrint('Role: $_selectedRole');
              debugPrint('Daily goal: $goal');
              debugPrint('Amount: $_selectedAmount');
              debugPrint('Usage: $_selectedUsage');
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
