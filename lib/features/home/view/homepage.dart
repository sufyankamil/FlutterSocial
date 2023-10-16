import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homepage extends ConsumerWidget {
  // Route for the homepage
  static route() => MaterialPageRoute(
        builder: (context) => const Homepage(),
      );

  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
