import 'package:flutter/material.dart';
import 'package:proctorlyflutter/load_buffer.dart';

class TeacherHomeScreen extends StatefulWidget {
  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  int _selectedIndex = 0;

  // Define a list of widget screens for each tab
  final List<Widget> _screens = [
    Center(child: Text('Home Screen')),     // Placeholder for Home screen
    Center(child: Text('Records Screen')),  // Placeholder for Records screen
    Center(child: Text('History Screen')),  // Placeholder for History screen
    Center(child: Text('Profile Screen')),  // Placeholder for Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Home'),
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.cyan, // Highlight selected tab in cyan
        unselectedItemColor: Colors.grey, // Unselected tabs in gray
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
