import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dailyhabit/providers/auth_provider.dart';
import 'package:dailyhabit/widgets/app_scaffold.dart';
import 'package:dailyhabit/routes.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppScaffold(
      title: 'Account',
      body: Container(
        color: theme.primaryColor,
        child: SafeArea(
          child: Consumer<AuthProvider>(
            builder: (context, auth, child) {
              return ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  // Profile Header
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // Profile Avatar
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: auth.isGuest 
                                ? Colors.grey.shade300 
                                : theme.primaryColor.withOpacity(0.2),
                            child: Icon(
                              auth.isGuest ? Icons.person_outline : Icons.person,
                              size: 50,
                              color: auth.isGuest 
                                  ? Colors.grey.shade700 
                                  : theme.primaryColor,
                            ),
                          ),
                          SizedBox(height: 16),
                          
                          // Username
                          Text(
                            auth.username ?? 'User',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          
                          // Account Type
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: auth.isGuest 
                                  ? Colors.grey.shade200 
                                  : theme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              auth.isGuest ? 'Guest Account' : 'Registered Account',
                              style: TextStyle(
                                color: auth.isGuest 
                                    ? Colors.grey.shade700 
                                    : theme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // Account Information
                  _buildSectionHeader(context, 'Account Information'),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person_outline),
                          title: Text('Username'),
                          trailing: Text(
                            auth.username ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.badge_outlined),
                          title: Text('User ID'),
                          trailing: Text(
                            auth.userId ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.security),
                          title: Text('Account Type'),
                          trailing: Text(
                            auth.isGuest ? 'Guest' : 'Registered',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // Actions
                  _buildSectionHeader(context, 'Actions'),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        if (!auth.isGuest)
                          ListTile(
                            leading: Icon(Icons.lock_outline),
                            title: Text('Change Password'),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // TODO: Implement change password functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Change password feature coming soon'),
                                ),
                              );
                            },
                          ),
                        if (!auth.isGuest)
                          Divider(height: 1),
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
                              await auth.logout();
                              // Navigate to auth page after logout
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.auth,
                                (route) => false, // Remove all previous routes
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
} 