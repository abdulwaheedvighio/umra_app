import 'package:flutter/material.dart';

class Utils {
  /// Show a Snackbar with custom message and optional color
  static void showSnackBar(BuildContext context, String message,
      {Color color = Colors.red, Duration duration = const Duration(seconds: 3)}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      duration: duration,
    );

    // Hide current snackbar if visible and show new
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Optional: Validate Email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Optional: Validate Password (minimum 6 chars)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
}
