import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  final String buttontext;
  const Buttons({super.key, required this.buttontext});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 70, right: 70),
      decoration: BoxDecoration(
        color: const Color.fromARGB(183, 42, 41, 41),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        widget.buttontext,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
