import 'package:flutter/material.dart';
import 'package:proctorlyflutter/load_buffer.dart';
import 'package:proctorlyflutter/load_buffer.dart'; // Import the LoadingScreen

class StudentSignUp extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await register(context); // Call register method
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> register(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Check if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Show loading screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadingScreen()),
    );

    // Simulate network request delay
    await Future.delayed(Duration(seconds: 1));

    // Here, implement the registration logic (e.g., calling Supabase or another backend)
    // For now, we'll assume registration is successful.
    bool registrationSuccess = true; // Placeholder for successful registration

    // Remove loading screen before showing the result
    Navigator.pop(context); // Remove loading screen

    if (registrationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful! Please sign in.')),
      );
      Navigator.pop(context); // Go back to the sign-in screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during registration')),
      );
    }
  }
}
