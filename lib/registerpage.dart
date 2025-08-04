import 'package:flutter/material.dart';
import 'package:flutter_application_8/buttons.dart';
import 'package:flutter_application_8/homepage.dart';
import 'package:flutter_application_8/mytextfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void signupUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.green),
                SizedBox(width: 8),
                Text("User registered! Please verify your email."),
              ],
            ),
          ),
        );

        Future.delayed(const Duration(seconds: 0), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("LOGIN CREDENTIALS ERROR!")));
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Register Now...",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.app_registration),
              ],
            ),
            const SizedBox(height: 30),
            Mytextfield(
              hinttext: "Email",
              obscuretext: false,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            Mytextfield(
              hinttext: "Password",
              obscuretext: true,
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            Mytextfield(
              hinttext: "Confirm Password",
              obscuretext: true,
              controller: confirmController,
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: signupUser,
              child: const Buttons(buttontext: "Register"),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 114, 203),
                    ),
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
