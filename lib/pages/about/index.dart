import 'package:flutter/material.dart';
import 'package:dailyhabit/widgets/app_scaffold.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'About',
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Text(
                'Daily Habit',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Version 1.0.0',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 32),
            _buildSection(
              context,
              'About the App',
              'Daily Habit is a simple and effective habit tracking application designed to help you build and maintain positive habits in your daily life.',
            ),
            SizedBox(height: 16),
            _buildSection(
              context,
              'Features',
              '• Track your daily habits\n• Set reminders for your habits\n• View your progress over time\n• Chat with AI assistant for habit advice',
            ),
            SizedBox(height: 16),
            _buildSection(
              context,
              'Contact',
              'For any questions or suggestions, please contact us at:\nsupport@dailyhabit.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
} 