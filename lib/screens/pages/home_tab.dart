import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome${userName != null ? ', $userName' : ''}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (dailyGoal != null)
              Text('Your daily AI goal: $dailyGoal times'),
          ],
        ),
      ),
    );
  }
}