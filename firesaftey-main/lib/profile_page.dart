import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'editstaffPage.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // User fields
  String safeFullName = "-";
  String safeGender = "-";
  String safeAge = "-";
  String safePhone = "-";
  String safeEmail = "-"; // ✅ Added
  String safePosition = "-";
  String safeShift = "-";
  String safeManagerName = "-";
  String formattedJoiningDate = "-";
  String safeHotel = "-";
  String safeLocation = "-";
  String safeModulesCompleted = "-";
  String formattedLastDrillDate = "-";
  String safeFireSafetyLevel = "-";
  String safeEmergencyRole = "-";

  Uint8List? profileImageBytes;
  bool isImageLoading = true;
  bool isManager = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final docSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      final basicInfo = data['Basic_Info'] ?? {};
      final jobInfo = data['Job_Info'] ?? {};
      final hotelInfo = data['Hotel_Info'] ?? {};
      final contactInfo = data['Contacts'] ?? {};
      final drillsInfo = data['Drills_Info'] ?? {};

      try {
        final base64Image = data['profile'] as String?;
        if (base64Image != null && base64Image.isNotEmpty) {
          final cleaned =
              base64Image.contains(',')
                  ? base64Image.split(',').last
                  : base64Image;
          final decoded = base64Decode(cleaned);
          setState(() {
            profileImageBytes = decoded;
            isImageLoading = false;
          });
        } else {
          setState(() => isImageLoading = false);
        }
      } catch (e) {
        print("❌ Image decode failed: $e");
        setState(() => isImageLoading = false);
      }

      setState(() {
        safeFullName = safeText(basicInfo['FullName']);
        safeGender = safeText(basicInfo['Gender']);

        final dobTimestamp = basicInfo['Age'] as Timestamp?;
        if (dobTimestamp != null) {
          final dob = dobTimestamp.toDate();
          safeAge = calculateAge(dob).toString();
        } else {
          safeAge = "-";
        }

        safePosition = safeText(jobInfo['Position']);
        safeShift = safeText(jobInfo['Shift']);
        safeManagerName = safeText(jobInfo['ManagerName']);
        formattedJoiningDate = formatDate(
          (jobInfo['Joining'] ?? jobInfo['Joinng'])?.toDate(),
        );

        safeHotel = safeText(hotelInfo['Hotel']);
        safeLocation = safeText(hotelInfo['Location']);

        safePhone = contactInfo['Phone']?.toString() ?? "-";
        safeEmail = contactInfo['Email']?.toString() ?? "-"; // ✅ Added

        safeModulesCompleted = safeText(drillsInfo['ModulesCompleted']);
        formattedLastDrillDate = formatDate(
          (drillsInfo['LastDrill'] as Timestamp?)?.toDate(),
        );
        safeFireSafetyLevel = safeText(drillsInfo['FireSafteyLevel']);
        safeEmergencyRole = safeText(drillsInfo['EmergencyRole']);

        final role = safeText(data['role']);
        isManager = role.toLowerCase() == 'manager';
      });
    } else {
      print("❌ No user data found.");
      setState(() => isImageLoading = false);
    }
  }

  int calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  String safeText(dynamic val) => val?.toString() ?? "-";

  String formatDate(DateTime? date) =>
      (date == null) ? "-" : DateFormat('dd/MM/yy').format(date);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final double horizontalPadding = isMobile ? 16 : 32;
    final double sectionWidth = isMobile ? double.infinity : 500;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF1E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF1E1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Profile", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 20,
            ),
            child: SizedBox(
              width: sectionWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔶 Profile Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5D6A8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.shade200,
                              child:
                                  isImageLoading
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
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                      : const Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: $safeFullName",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Age: $safeAge"),
                                  Text("Position: $safePosition"),
                                  Text("Hotel Name: $safeHotel"),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => EditStaffPage(
                                          staffId: widget.userId,
                                        ),
                                  ),
                                ).then((_) => fetchUserData()); // refresh
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: widget.userId,
                          width: 200,
                          height: 50,
                          drawText: false,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const _SectionTitle(
                    "Basic Info",
                    Icons.diamond,
                    color: Colors.blue,
                  ),
                  _InfoRow("Full Name", safeFullName),
                  _InfoRow("Age", safeAge),
                  _InfoRow("Gender", safeGender),
                  _InfoRow("Employee ID", widget.userId),
                  const Divider(height: 32),

                  const _SectionTitle(
                    "Contact Info",
                    Icons.contact_mail,
                    color: Colors.teal,
                  ),
                  _InfoRow("Email", safeEmail),
                  _InfoRow("Phone", safePhone),
                  const Divider(height: 32),

                  const _SectionTitle(
                    "Hotel Info",
                    Icons.apartment,
                    color: Colors.brown,
                  ),
                  _InfoRow("Hotel", safeHotel),
                  _InfoRow("Location", safeLocation),
                  const Divider(height: 32),

                  const _SectionTitle(
                    "Job Info",
                    Icons.badge,
                    color: Colors.indigo,
                  ),
                  _InfoRow("Position", safePosition),
                  if (!isManager) ...[_InfoRow("Shift Timings", safeShift)],
                  _InfoRow("Date of Joining", formattedJoiningDate),
                  if (!isManager) ...[
                    _InfoRow("Manager Name", safeManagerName),
                  ],
                  const Divider(height: 32),

                  if (!isManager) ...[
                    const _SectionTitle(
                      "Drill Info",
                      Icons.local_fire_department,
                      color: Colors.red,
                    ),
                    _InfoRow("Modules Completed", safeModulesCompleted),
                    _InfoRow("Last Drill Date", formattedLastDrillDate),
                    _InfoRow("Fire Safety Level", safeFireSafetyLevel),
                    _InfoRow("Emergency Role", safeEmergencyRole),
                    const Divider(height: 32),
                  ],

                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.redAccent),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, this.icon, {this.color = Colors.black});

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: RichText(
        text: TextSpan(
          text: "$label: ",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
