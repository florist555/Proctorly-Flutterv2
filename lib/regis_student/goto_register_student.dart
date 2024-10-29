import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    final email = emailController.text.trim();
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

    try {
      // Call Supabase to register the user
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      // Remove loading screen
      Navigator.pop(context); // Remove loading screen

      // Check if registration was successful
      if (response.user != null) {
        // Successful registration
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful! Please sign in.')),
        );

        // Optionally, navigate to another screen (e.g., sign-in screen)
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
      } else {
        // Handle registration error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed due to an unknown issue.')),
        );
      }
    } catch (error) {
      // Remove loading screen
      Navigator.pop(context); // Remove loading screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during registration: $error')),
      );
    }
  }
}
