import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'roleselect_page.dart'; // Import roleselect_page
import 'package:device_preview/device_preview.dart'; // Add this import
import 'regis_student/goto_register_student.dart';
import 'nav_student/studentsignin.dart';


void main() async {
  await Supabase.initialize(
    url: 'https://idymuknqrhgjpytlekjp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlkeW11a25xcmhnanB5dGxla2pwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAwOTk3MzEsImV4cCI6MjA0NTY3NTczMX0.mhpmGZ0DE_1kGUuE1L6ZoIAi63vg2rvTuk-m8CA71oI',
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enables device preview in debug mode
      builder: (context) => MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, // Required for DevicePreview
      locale: DevicePreview.locale(context), // Add the locale from device_preview
      builder: DevicePreview.appBuilder, // Wrap the app with the DevicePreview builder
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/', // Set the initial route to FirstPage
      routes: {
        '/': (context) => FirstPage(),
        '/studentSignIn': (context) => StudentSignInScreen(), // Add sign-in route
        '/studentRegis': (context) => StudentSignUp(), // Add registration route
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 150), // Replace with your logo
              SizedBox(height: 20),
              Text(
                'Your journey to secure, seamless, and efficient online examinations starts here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate to ChooseRole page when pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseRole()),
                  );
                },
                child: Text('Choose Your Role'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.black, // Button color
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to Student Sign-In page
                  Navigator.pushNamed(context, '/studentSignIn');
                },
                child: Text('Sign In', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
