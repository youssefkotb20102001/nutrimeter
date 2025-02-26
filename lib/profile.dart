import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/welcomePage.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.client});
  Clients_info client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'PROFILE',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Profile Picture Section
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade200,
            child: Icon(Icons.person, size: 80, color: Colors.grey),
          ),
          SizedBox(height: 10),
          // User Information
          Text(
            client.username!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            client.mail!,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          // Options List
          Expanded(
            child: ListView(
              children: [
                ProfileOption(
                  icon: Icons.edit,
                  label: 'Edit Profile',
                  onPressed: () {},
                ),
                ProfileOption(
                  icon: Icons.star,
                  label: 'My Weight',
                  onPressed: () {},
                ),
                ProfileOption(
                  icon: Icons.photo,
                  label: 'My Photos',
                  onPressed: () {},
                ),
                ProfileOption(
                  icon: Icons.privacy_tip,
                  label: 'Terms & Privacy Policy',
                  onPressed: () {},
                ),
                ProfileOption(
                  icon: Icons.logout,
                  label: 'Log Out',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Profile Options
class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ProfileOption({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
