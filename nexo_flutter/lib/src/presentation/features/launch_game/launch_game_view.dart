import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LaunchGameView extends ConsumerWidget {
  const LaunchGameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Launch Game"),
      ),
      body: const Center(
        child: Text("Launch Game"),
      ),
    );
  }
}
