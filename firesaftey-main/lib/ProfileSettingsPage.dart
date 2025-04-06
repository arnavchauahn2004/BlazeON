import 'package:flutter/material.dart';


class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Profile Settings', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('Update your personal details anytime.'),
            ),
            ListTile(
              title: Text('Privacy & Security', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('Manage your data and control your privacy settings.'),
            ),
            ListTile(
              title: Text('Language', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('Choose your preferred language for a better experience.'),
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('Securely sign out of your account anytime.'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
