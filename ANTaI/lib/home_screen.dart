import 'package:flutter/material.dart';
import 'screens/onboarding/name_page.dart';
import 'screens/onboarding/usage_reason_page.dart';
import 'screens/onboarding/role_page.dart';
import 'screens/onboarding/amount_page.dart';
import 'screens/onboarding/goal_page.dart';
import 'main_app_screen.dart';

// TODO: Advanced error checking on the onboarding questions
// TODO: Resolve groupValue and onChanged errors

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;

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
    _pageController.dispose();
    nameController.dispose();
    goalController.dispose();
    super.dispose();
  }
  
  void _next() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submit();
    }
  }

  void _back() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submit() {
    final name = nameController.text.trim();
    final goal = goalController.text.trim();
    debugPrint('Name: $name');
    debugPrint('Why control: $_selectedUsageReason');
    debugPrint('Role: $_selectedRole');
    debugPrint('Current usage: $_selectedAmount');
    debugPrint('Daily goal: $goal');

    // TODO: Save data from onboarding questions
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainAppScreen(),
      ),
    );
  }

  List<Widget> get _pages => [
    NamePage(controller: nameController),
    UsageReasonPage(
      usages: _usages,
      selected: _selectedUsageReason,
      onChanged: (val) => setState(() => _selectedUsageReason = val),
    ),
    RolePage(
      roles: _roles,
      selected: _selectedRole,
      onChanged: (val) => setState(() => _selectedRole = val),
    ),
    AmountPage(
      amounts: _amounts,
      selected: _selectedAmount,
      onChanged: (val) => setState(() => _selectedAmount = val),
    ),
    GoalPage(controller: goalController),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = _pages;

    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding questions')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentIndex = i),
                children: pages,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (_currentIndex > 0)
                  TextButton(
                    onPressed: _back,
                    child: const Text('Back'),
                  ),
                const Spacer(),
                FilledButton(
                  onPressed: _next,
                  child: Text(
                    _currentIndex == pages.length-1 ? 'Finish' : 'Continue',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
