import 'package:flutter/material.dart';

class InfoGuidePage extends StatelessWidget {
  const InfoGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Info Guide', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Getting Started', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('Learn how to set up and use the platform effortlessly.'),
            ),
            ListTile(
              title: Text('Features', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('Explore the key functionalities designed to enhance your experience.'),
            ),
            ListTile(
              title: Text('Navigation', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('Easily find your way around with our intuitive interface.'),
            ),
            ListTile(
              title: Text('Troubleshooting', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('Get quick fixes for common issues and technical support.'),
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
