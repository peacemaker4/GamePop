import 'dart:developer';

import 'package:flutter_project_app/services/firebase_auth_methods.dart';
import 'package:flutter_project_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project_app/main.dart';
class EmailPasswordSignup extends StatefulWidget {

  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpUser() async {
    // final userPlatform = Provider.of<UserPlatform>(context, listen: false);
    context.read<FirebaseAuthMethods>().signUpWithEmail(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );

  }
  void navigateToSignInPage() {
    Navigator.pushNamed(context, '/login'); // Replace '/auth' with your actual route name for the sign-up page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: signUpUser,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: navigateToSignInPage,
            child: const Text(
              "Sign In",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
