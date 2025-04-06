import 'package:flutter/material.dart';
import 'package:firesaftey/animated_fire_background.dart';
import 'package:firesaftey/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController hotelIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String countryCode = "+91";

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    print("---- User Details ----");
    print("Name: ${nameController.text}");
    print("Date of Birth: ${dobController.text}");
    print("Gender: ${genderController.text}");
    print("Email: ${emailController.text}");
    print("Phone: $countryCode ${phoneController.text}");
    print("Hotel ID: ${hotelIdController.text}");
    print("Password: ${passwordController.text}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Signed up successfully!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedFireBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 24),
                  Center(
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.pink[100],
                      child: Icon(Icons.person, size: 40, color: Colors.brown),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Setting up your account",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildTextField("Name", "John Doe", controller: nameController),
                  _buildDateField("Date of Birth", dobController),
                  _buildTextField("Gender", "Male/Female/Others", controller: genderController),
                  _buildTextField("Email", "example@gmail.com", controller: emailController, keyboardType: TextInputType.emailAddress),
                  _buildPhoneField(),
                  _buildTextField("Hotel ID", "abc123yzx", controller: hotelIdController),
                  _buildTextField("Password", "************", controller: passwordController, obscureText: true),
                  _buildTextField("Confirm Password", "************", controller: confirmPasswordController, obscureText: true),
                  SizedBox(height: 24),
                  GradientButton(
                    text: "Activate your account",
                    onPressed: _submitForm,
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {required TextEditingController controller,
      bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) => value == null || value.isEmpty ? "Please enter $label" : null,
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'dd/mm/yyyy',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          }
        },
        validator: (value) => value == null || value.isEmpty ? "Please select $label" : null,
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: countryCode,
              items: <String>["+91", "+1", "+44"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newCode) {
                setState(() {
                  countryCode = newCode!;
                });
              },
              underline: SizedBox(),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              validator: (value) => value == null || value.isEmpty ? "Enter phone number" : null,
            ),
          ),
        ],
      ),
    );
  }
}

/// ✅ Reusable GradientButton Widget
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD32F2F), Color(0xFFFF8F00)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: padding ?? EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
