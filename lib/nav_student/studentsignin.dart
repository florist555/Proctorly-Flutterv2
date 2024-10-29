import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
              child: Text('Sign In'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await signInWithGitHub(context); // Call GitHub login method
              },
              child: Text('Sign In with GitHub'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/studentRegis');
              },
              child: Text('Don\'t have an account? Register', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingScreen()));

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      Navigator.pop(context); // Remove loading screen

      // Check if a user exists in the response
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()), // Navigate to Dashboard
        );
      } else {
        // Handle sign-in failure
        throw 'Invalid email or password';
      }
    } catch (error) {
      Navigator.pop(context); // Remove loading screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: $error')),
      );
    }
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    try {
      // Start GitHub OAuth login
      final response = await Supabase.instance.client.auth.signInWithOAuth(
        Provider.github,
        redirectTo: 'io.supabase.flutter://login-callback', // Make sure this matches your redirect URI
      );

      // GitHub sign-in doesn't return user info directly; handle based on flow
      if (response) { // Assuming response is a boolean for success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('GitHub sign-in initiated.')),
        );
        // You will need to handle the callback on your redirect URI
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('GitHub sign-in failed. Please try again.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during GitHub sign-in: $error')),
      );
    }
  }
}
