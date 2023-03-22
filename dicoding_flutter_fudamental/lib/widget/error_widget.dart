import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final Function() tryAgain;

  const ErrorMessage(
      {super.key, required this.message, required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(onPressed: tryAgain, child: const Text("Coba Lagi"))
        ],
      ),
    );
  }
}
