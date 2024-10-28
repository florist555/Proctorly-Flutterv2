import 'package:flutter/material.dart';
import 'teacherhomepage.dart'; // Import the TeacherHomeScreen

class TeacherSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Teacher Sign In')),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await signInAsTeacher(context, emailController.text, passwordController.text);
              },
              child: Text('Sign In as Teacher'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInAsTeacher(BuildContext context, String email, String password) async {
    // This is where you would implement your teacher sign-in logic
    // For example, using Supabase or any other authentication method
    // Replace this placeholder logic with actual sign-in success check
    bool signInSuccess = true; // Placeholder for successful sign-in

    if (signInSuccess) {
      print('Sign in successful: $email');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in successful!')),
      );
      // Navigate to the TeacherHomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TeacherHomeScreen()), // Navigate to TeacherHomeScreen
      );
    } else {
      final errorMessage = 'Invalid email or password'; // Replace with actual error message
      print('Error signing in: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: $errorMessage')),
      );
    }
  }
}
