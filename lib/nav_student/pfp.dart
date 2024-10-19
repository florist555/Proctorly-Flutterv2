import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image picker package
import 'dart:io'; // To handle file paths for the profile picture

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Temporary data for the profile (name, email, section, profile picture)
  String _name = 'Student Name';
  String _email = 'student@example.com';
  String _section = 'Section 1';
  File? _profileImage;

  // Function to update profile data after editing
  void _updateProfile(String name, String email, String section, File? image) {
    setState(() {
      _name = name;
      _email = email;
      _section = section;
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!) // Show selected image
                : AssetImage('assets/profile_placeholder.png') as ImageProvider,
          ),
          const SizedBox(height: 20),
          Text(
            _name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _email,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            'Section: $_section',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to the EditProfileScreen to edit profile
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    currentName: _name,
                    currentEmail: _email,
                    currentSection: _section,
                    currentImage: _profileImage,
                    onSave: _updateProfile, // Pass the update function
                  ),
                ),
              );
            },
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentSection;
  final File? currentImage;
  final Function(String, String, String, File?) onSave;

  const EditProfileScreen({
    required this.currentName,
    required this.currentEmail,
    required this.currentSection,
    required this.currentImage,
    required this.onSave,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _email;
  late String _section;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _name = widget.currentName;
    _email = widget.currentEmail;
    _section = widget.currentSection;
    _imageFile = widget.currentImage;
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!) // Display selected image
                        : AssetImage('assets/profile_placeholder.png') as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: _email,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: _section,
                  decoration: InputDecoration(labelText: 'Section'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your section';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _section = value!;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.onSave(_name, _email, _section, _imageFile);
                      Navigator.pop(context); // Go back to the profile screen
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
