import 'package:flutter/material.dart';

class Mytextfield extends StatefulWidget {
  final String hinttext;
  final bool obscuretext;
  final TextEditingController controller;
  const Mytextfield({
    super.key,
    required this.hinttext,
    required this.obscuretext,
    required this.controller,
  });

  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscuretext,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 109, 107, 107),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(92, 255, 255, 255),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hinttext,
        ),
      ),
    );
  }
}
