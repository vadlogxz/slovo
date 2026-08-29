import 'package:flutter/material.dart';
import 'package:slovo/core/theme/app_spacing.dart';

class SessionSummaryScreen extends StatelessWidget {
  const SessionSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Center(
            child: Text('You have finished the learning session.'),
          ),
        ),
      ),
    );
  }
}
