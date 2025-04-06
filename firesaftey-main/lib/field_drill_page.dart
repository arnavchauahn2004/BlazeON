import 'package:flutter/material.dart';

class FieldDrillPage extends StatefulWidget {
  const FieldDrillPage({super.key});

  @override
  _FieldDrillPageState createState() => _FieldDrillPageState();
}

class _FieldDrillPageState extends State<FieldDrillPage> {
  String _filter = '';

  // Sample list of drills with score
  List<Map<String, dynamic>> drills = [
    {
      'title': 'Housekeeping: Spotting and Reporting Fire Hazards',
      'status': 'In-Progress',
    },
    {'title': 'Kitchen: Handling a Minor Grease Fire', 'status': 'Completed'},
    {
      'title': 'Security: Directing Crowds Safely to Exits',
      'status': 'In-Progress',
    },
    {
      'title': 'Maintenance: Simulated Power Shutdown',
      'status': 'Yet-to-start',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<String> selectedFilters =
        _filter.isEmpty ? [] : _filter.split(',').toList();

    List<Map<String, dynamic>> filteredDrills =
        drills.where((drill) {
          return selectedFilters.isEmpty ||
              selectedFilters.contains(drill['status']);
        }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Field Drill', style: TextStyle(color: Colors.white)),
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
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/field_drill.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: ListView.builder(
              itemCount: filteredDrills.length,
              itemBuilder: (context, index) {
                final drill = filteredDrills[index];
                return _buildDrillCard(drill['title'], drill['status']);
              },
            ),
          ),
        ],
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

  Widget _buildDrillCard(String title, String status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.orange),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        onTap: () {
          // Navigate to drill details page
        },
      ),
    );
  }
}
