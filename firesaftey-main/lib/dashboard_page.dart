import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chat_page.dart';
import 'report_page.dart';
import 'setting.dart';
import 'profile_page.dart';
import 'tutorials_page.dart';
import 'common_drill_page.dart';
import 'field_drill_page.dart';

class DashboardPage extends StatefulWidget {
  final String userId;
  const DashboardPage({super.key, required this.userId});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _scrollController = ScrollController();
  late DateTime _selectedDate;
  Uint8List? profileImageBytes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userId)
              .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        final base64Image = data['profile'] as String?;

        if (base64Image != null && base64Image.isNotEmpty) {
          final cleanedBase64 =
              base64Image.contains(',')
                  ? base64Image.split(',').last
                  : base64Image;

          final decodedBytes = base64Decode(cleanedBase64);
          setState(() {
            profileImageBytes = decodedBytes;
            isLoading = false;
          });
        } else {
          print("⚠️ No image data found.");
          setState(() => isLoading = false);
        }
      } else {
        print("❌ No user data found.");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('❌ Error fetching user data: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('d MMMM').format(_selectedDate);
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFFDF0DC),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 32,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'BlazeON',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.notifications_none,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Notifications coming soon!"),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            ProfilePage(userId: widget.userId),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey.shade200,
                                child:
                                    isLoading
                                        ? const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.grey,
                                              ),
                                        )
                                        : profileImageBytes != null
                                        ? ClipOval(
                                          child: Image.memory(
                                            profileImageBytes!,
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                        : const Icon(
                                          Icons.person,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Progress',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _scrollController.animateTo(
                                    _scrollController.offset - 100,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(daysInMonth, (
                                      index,
                                    ) {
                                      final int day = index + 1;
                                      final bool isSelected =
                                          day == _selectedDate.day;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedDate = DateTime(
                                                now.year,
                                                now.month,
                                                day,
                                              );
                                            });
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  isSelected
                                                      ? Colors.white
                                                      : Colors.transparent,
                                              border: Border.all(
                                                color:
                                                    isSelected
                                                        ? Colors.deepPurple
                                                        : Colors.grey,
                                                width: isSelected ? 3 : 1,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '$day',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                    isSelected
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _scrollController.animateTo(
                                    _scrollController.offset + 100,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildImageCard(
                            "TUTORIALS",
                            "lib/assets/tutorials.jpg",
                            const TutorialPage(),
                          ),
                          const SizedBox(height: 16),
                          _buildImageCard(
                            "COMMON DRILL",
                            "lib/assets/common_drill.jpg",
                            const CommonDrillPage(),
                          ),
                          const SizedBox(height: 16),
                          _buildImageCard(
                            "FIELD DRILL",
                            "lib/assets/field_drill.jpg",
                            const FieldDrillPage(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(userId: widget.userId),
              ),
            );
          },
          backgroundColor: const Color(0xFFD09A5B),
          child: const Icon(Icons.chat, color: Colors.white),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFFD09A5B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, Icons.article, "Report"),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.home, size: 32, color: Colors.orange),
                ),
                const SizedBox(width: 16),
                _buildNavItem(context, Icons.settings, "Settings"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String title, String assetPath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        if (label == "Report") {
          Navigator.pushReplacement(
            context,
            _createRoute(ReportPage(userId: widget.userId), fromLeft: true),
          );
        } else if (label == "Settings") {
          Navigator.pushReplacement(
            context,
            _createRoute(Setting(userId: widget.userId), fromLeft: false),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Route _createRoute(Widget page, {bool fromLeft = false}) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(fromLeft ? -1.0 : 1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
