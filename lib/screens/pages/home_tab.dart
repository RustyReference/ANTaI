import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/todo_list.dart';
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String? userName;
  String? dailyGoal;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      dailyGoal = prefs.getString('daily_goal');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Welcome${userName != null ? ', $userName' : ''}!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            if (dailyGoal != null)
              Center(child: Text('Your daily AI goal: $dailyGoal times')),
            const SizedBox(height: 25),
            const Expanded(child: TodoList()),
          ],
        ),
      ),
    );
  }
}