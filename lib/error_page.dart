import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Screen')),
      body: const Center(
        child: Text(
          "We couldn't find the page you're looking for",
        ),
      ),
    );
  }
}
