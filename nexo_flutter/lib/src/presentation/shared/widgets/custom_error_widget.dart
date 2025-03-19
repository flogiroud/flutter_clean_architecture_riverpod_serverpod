import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final Object error;

  const CustomErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Text(
      error.toString(),
      style: const TextStyle(color: Colors.red),
    );
  }
}
