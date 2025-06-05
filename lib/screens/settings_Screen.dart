import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/favorites_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.brightness_6),
                    title: const Text('Design'),
                    trailing: DropdownButton<ThemeMode>(
                      value: themeProvider.themeMode,
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('System'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('Hell'),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('Dunkel'),
                        ),
                      ],
                      onChanged: (ThemeMode? mode) {
                        if (mode != null) {
                          themeProvider.setThemeMode(mode);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Über die App'),
                    subtitle: const Text('MY SPORTS v1.0.0'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('MY SPORTS'),
                          content: const Text(
                            'Eine App zur Verwaltung deiner Lieblingssportarten, Wettbewerbe und Teams.\n\nVersion: 1.0.0',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(Icons.code),
                    title: Text('Entwickelt mit Flutter'),
                    subtitle: Text('Dart & Flutter Framework'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.api),
                    title: Text('API Status'),
                    subtitle: Text('Verbindung zu Sport-APIs'),
                    trailing: Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 12,
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.refresh),
                    title: const Text('Favoriten löschen'),
                    subtitle: const Text('Lösche sämtliche Favoriten'),
                    onTap: () {
                      Provider.of<FavoritesProvider>(context, listen: false).clearAllFavorites();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Daten werden gelöscht...'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}