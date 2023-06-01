import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  ProfilePage();

  void _logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Redirect the user to the login page or any other desired page
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login', // Replace '/login' with your actual login page route
            (route) => false, // Remove all previous routes from the stack
      );
    } catch (e) {
      // Handle log out error
      print('Log out error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => _logOut(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user?.displayName ?? 'Guest'}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            if (user?.email != null)
              Text(
                'Email: ${user?.email}',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
