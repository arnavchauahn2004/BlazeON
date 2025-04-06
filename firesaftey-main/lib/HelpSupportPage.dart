import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Help & Support', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Header
            const Text(
              '9:30',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            const Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF8B2C2C),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // List of Help Options
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) => const Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      _getHelpTitle(index),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        _getHelpDescription(index),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    onTap: () {
                      // Handle navigation or any additional actions on tap
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFD09A5B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 2, // Settings tab selected by default
        onTap: (index) {
          
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Helper function to return titles
  String _getHelpTitle(int index) {
    switch (index) {
      case 0:
        return 'Customer Support';
      case 1:
        return 'Your Queries';
      case 2:
        return 'FAQs';
      default:
        return '';
    }
  }

  // Helper function to return descriptions
  String _getHelpDescription(int index) {
    switch (index) {
      case 0:
        return 'For help, contact our support team via email or phone.';
      case 1:
        return 'View your past and current queries here.';
      case 2:
        return 'Find answers to common questions here.';
      default:
        return '';
    }
  }
}
