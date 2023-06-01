import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_app/profile.dart';
import 'package:flutter_project_app/services/firebase_auth_methods.dart';
import 'package:flutter_project_app/widgets/custom_button.dart';
import 'package:flutter_project_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailPasswordLogin extends StatefulWidget {
  const EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  _EmailPasswordLoginState createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
      email: emailController.text,
      password: passwordController.text,
      context: context,
      onSuccess: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
    );
  }

  void loginAsGuest() {
    Navigator.pushNamed(context, '/');
  }

  void navigateToSignUpPage() {
    Navigator.pushNamed(context, '/auth'); // Replace '/auth' with your actual route name for the sign-up page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
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
            onPressed: loginUser,
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
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: navigateToSignUpPage,
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: loginAsGuest,
            child: const Text(
              "Login as Guest",
              style: TextStyle(fontSize: 16),
            ),
          ),
          CustomButton(
            onTap: () {
              context.read<FirebaseAuthMethods>().signInWithGoogle(context);
            },
            text: 'Google Sign In',
          ),
        ],
      ),
    );
  }
}
