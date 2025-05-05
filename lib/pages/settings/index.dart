import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dailyhabit/providers/settings_provider.dart';
import 'package:dailyhabit/widgets/app_scaffold.dart';
import 'package:dailyhabit/l10n/app_localizations.dart';
import 'package:dailyhabit/providers/auth_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    return AppScaffold(
      title: localizations.settings,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Consumer<SettingsProvider>(
            builder: (context, settings, child) {
              return ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  _buildSectionHeader(context, localizations.theme),
                  Card(
                    child: Column(
                      children: [
                        RadioListTile<ThemeMode>(
                          title: Text(localizations.system),
                          value: ThemeMode.system,
                          groupValue: settings.themeMode,
                          onChanged: (ThemeMode? value) async {
                            if (value != null) {
                              await settings.setThemeMode(value, context);
                            }
                          },
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text(localizations.light),
                          value: ThemeMode.light,
                          groupValue: settings.themeMode,
                          onChanged: (ThemeMode? value) async {
                            if (value != null) {
                              await settings.setThemeMode(value, context);
                            }
                          },
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text(localizations.dark),
                          value: ThemeMode.dark,
                          groupValue: settings.themeMode,
                          onChanged: (ThemeMode? value) async {
                            if (value != null) {
                              await settings.setThemeMode(value, context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildSectionHeader(context, localizations.language),
                  Card(
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: Text(localizations.english),
                          value: 'en',
                          groupValue: settings.locale.languageCode,
                          onChanged: (String? value) async {
                            if (value != null) {
                              await settings.setLocale(value, context);
                            }
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(localizations.russian),
                          value: 'ru',
                          groupValue: settings.locale.languageCode,
                          onChanged: (String? value) async {
                            if (value != null) {
                              await settings.setLocale(value, context);
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