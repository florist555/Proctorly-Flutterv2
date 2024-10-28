import 'package:flutter/material.dart';
import 'teacherhomepage.dart'; // Import the TeacherHomeScreen
import 'package:proctorlyflutter/regis_teacher/goto_register_teacher.dart'; // Import the TeacherSignUp screen
import 'package:proctorlyflutter/load_buffer.dart'; // Ensure your loading screen is correctly imported

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
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeacherSignUp()), // Navigate to registration page
                );
              },
              child: Text('Don\'t have an account? Register here.', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInAsTeacher(BuildContext context, String email, String password) async {
    // Show loading screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadingScreen()), // Ensure LoadingScreen is implemented
    );

    // Simulate network request delay
    await Future.delayed(Duration(seconds: 1));

    // Placeholder for successful sign-in logic
    bool signInSuccess = true; // Replace with actual sign-in logic using Supabase or similar

    // Remove loading screen before showing result
    Navigator.pop(context); // Remove the loading screen

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
