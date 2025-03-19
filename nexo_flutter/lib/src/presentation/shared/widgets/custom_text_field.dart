import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String text;
  final String? errorText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.text,
      this.enabled = true,
      this.errorText,
      this.onChanged,
      this.keyboardType,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white70,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      child: TextField(
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(
            color: Colors.white30,
          ),
          errorText: errorText,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
