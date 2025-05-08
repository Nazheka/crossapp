import 'package:flutter/material.dart';
import 'package:dailyhabit/routes.dart';
import 'package:provider/provider.dart';
import 'package:dailyhabit/providers/auth_provider.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool showDrawer;
  final List<Widget>? actions;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  AppScaffold({
    Key? key,
    required this.body,
    this.title = '',
    this.showDrawer = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        leading: showDrawer
            ? IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              )
            : null,
        actions: actions,
      ),
      body: body,
      drawer: showDrawer ? _buildDrawer(context) : null,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    authProvider.isGuest ? Icons.person_outline : Icons.person,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  authProvider.username ?? 'User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  authProvider.isGuest ? 'Guest Account' : 'Registered Account',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (authProvider.isGuest)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Please log in to access all features',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          if (!authProvider.isGuest) ...[
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.home);
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat with AI'),
              onTap: () {
                Navigator.pushNamed(context, Routes.chat);
              },
            ),
            Divider(),
          ],
          if (!authProvider.isGuest)
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Account'),
              onTap: () {
                Navigator.pushNamed(context, Routes.account);
              },
            ),
          if (!authProvider.isGuest)
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, Routes.settings);
              },
            ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.pushNamed(context, Routes.about);
            },
          ),
          Spacer(),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirm Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Logout', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              
              if (confirmed == true) {
                await authProvider.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.auth,
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
} 