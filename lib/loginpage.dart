import 'package:flutter/material.dart';
import 'package:flutter_application_8/buttons.dart';
import 'package:flutter_application_8/homepage.dart';
import 'package:flutter_application_8/mytextfield.dart';
import 'package:flutter_application_8/registerpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController paswordcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    paswordcontroller.dispose();
    super.dispose();
  }

  Future<void> signinuser() async {
    final email = emailcontroller.text.trim();
    final password = paswordcontroller.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception:', '').trim();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login Failed: $errorMessage')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.message, size: 70, color: Colors.grey),
              const SizedBox(height: 20),
              const Text("Welcome back", style: TextStyle()),
              const SizedBox(height: 20),
              Mytextfield(
                hinttext: 'EMAIL',
                obscuretext: false,
                controller: emailcontroller,
              ),
              const SizedBox(height: 10),
              Mytextfield(
                hinttext: 'PASSWORD',
                obscuretext: true,
                controller: paswordcontroller,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: signinuser,
                child: const Buttons(buttontext: 'Login'),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Registerpage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 131, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
