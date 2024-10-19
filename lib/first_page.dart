import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'roleselect_page.dart';  // Import roleselect_page
import 'package:device_preview/device_preview.dart'; // Add this import

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enables device preview in debug mode
      builder: (context) => MyApp(),
    ),
  );
}

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
      home: FirstPage(),
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
                  // Add functionality to navigate to Sign In page
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
