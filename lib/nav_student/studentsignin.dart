import 'package:flutter/material.dart';
import 'package:proctorlyflutter/load_buffer.dart';
import 'studenthome.dart'; // Make sure to import your DashboardScreen
import 'package:proctorlyflutter/load_buffer.dart'; // Import the LoadingScreen

class StudentSignInScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In as Student')),
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
                await signIn(context); // Call signIn method
              },
              child: Text('Sign In'), // Keep button text as 'Sign In'
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/studentRegis'); // Corrected route name
              },
              child: Text('Don\'t have an account? Register', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    // Show loading screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadingScreen()),
    );

    // Simulate network request delay
    await Future.delayed(Duration(seconds: 1));

    // Implement your sign-in logic here
    // For example, using Supabase:
    // final response = await Supabase.instance.client.auth.signIn(
    //   email: emailController.text,
    //   password: passwordController.text,
    // );

    // Replace the below line with the actual sign-in success check
    bool signInSuccess = true; // This is a placeholder for successful sign-in

    // Remove loading screen before showing the result
    Navigator.pop(context); // Remove loading screen

    if (signInSuccess) {
      print('Sign in successful: ${emailController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in successful!')),
      );
      // Navigate to the DashboardScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()), // Navigate to Dashboard
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
