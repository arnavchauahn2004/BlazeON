import 'package:flutter/material.dart';
import 'understanding_fire_behavior_page.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  String _filter = '';

  // Sample list of tutorials
  List<Map<String, String>> tutorials = [
    {'title': 'Understanding Fire Behavior', 'status': 'Completed'},
    {'title': 'Reading Your Environment', 'status': 'In-Progress'},
    {'title': 'Types of Fire Safety Equipment', 'status': 'Yet-to-start'},
    {'title': 'How to Respond Under Pressure', 'status': 'Completed'},
    {'title': 'Communication in Emergencies', 'status': 'Yet-to-start'},
    {
      'title': 'Understanding Your Role in Fire Response',
      'status': 'In-Progress',
    },
    {'title': 'Basic First Aid for Fire Incidents', 'status': 'Completed'},
    {'title': 'Evacuation Psychology', 'status': 'Yet-to-start'},
    {'title': 'When to Act and When to Step Back', 'status': 'Completed'},
    {'title': 'After the Fire: Reporting and Review', 'status': 'In-Progress'},
  ];

  @override
  Widget build(BuildContext context) {
    List<String> selectedFilters =
        _filter.isEmpty ? [] : _filter.split(',').toList();

    List<Map<String, String>> filteredTutorials =
        tutorials.where((tutorial) {
          return selectedFilters.isEmpty ||
              selectedFilters.contains(tutorial['status']);
        }).toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("lib/assets/tutorials.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Tutorials',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () {
                  _showFilterOptions(context);
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: filteredTutorials.length,
            itemBuilder: (context, index) {
              final tutorial = filteredTutorials[index];
              return _buildTutorialCard(
                tutorial['title']!,
                tutorial['status']!,
              );
            },
          ),
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    List<String> selectedFilters = _filter.split(',').toList();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              color: Colors.black.withOpacity(0.8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CheckboxListTile(
                    title: const Text(
                      'Completed',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: selectedFilters.contains('Completed'),
                    onChanged: (bool? value) {
                      setModalState(() {
                        if (value == true) {
                          selectedFilters.add('Completed');
                        } else {
                          selectedFilters.remove('Completed');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                      'In-Progress',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: selectedFilters.contains('In-Progress'),
                    onChanged: (bool? value) {
                      setModalState(() {
                        if (value == true) {
                          selectedFilters.add('In-Progress');
                        } else {
                          selectedFilters.remove('In-Progress');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                      'Yet-to-start',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: selectedFilters.contains('Yet-to-start'),
                    onChanged: (bool? value) {
                      setModalState(() {
                        if (value == true) {
                          selectedFilters.add('Yet-to-start');
                        } else {
                          selectedFilters.remove('Yet-to-start');
                        }
                      });
                    },
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        _filter = selectedFilters.join(',');
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTutorialCard(String title, String status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white.withOpacity(0.8),
      child: ListTile(
        leading: Icon(Icons.school, color: _getStatusColor(status)),
        title: Text(title, style: const TextStyle(color: Colors.black)),
        subtitle: Text(status, style: const TextStyle(color: Colors.black54)),
        trailing: const Icon(Icons.arrow_forward, color: Colors.black),
        onTap: () {
          if (title == 'Understanding Fire Behavior') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UnderstandingFireBehaviorPage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TutorialDetailPage(title: title),
              ),
            );
          }
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In-Progress':
        return Colors.orange;
      case 'Yet-to-start':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}

class TutorialDetailPage extends StatelessWidget {
  final String title;

  const TutorialDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Detailed content for $title')),
    );
  }
}
