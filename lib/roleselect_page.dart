import 'package:flutter/material.dart';
import 'package:proctorlyflutter/nav_student/studenthome.dart';
import 'studenthomepage.dart'; // Import the Dashboard screen

class ChooseRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Role'),
        leading: BackButton(onPressed: () {
          Navigator.pop(context); // Go back to the previous page
        }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 150),

            SizedBox(height: 40),
            Text('Choose Your Role', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to teacher-specific screen
                  },
                  child: Text('Teacher'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.black, // Button color
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to student-specific screen (DashboardScreen)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()), // Navigate to DashboardScreen
                    );
                  },
                  child: Text('Student'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.black, // Button color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
