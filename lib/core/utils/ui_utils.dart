import 'package:flutter/material.dart';

class UiUtils {
  static void showSnackBar(BuildContext context,{ required String message , bool isError = false , Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message , style: TextStyle(color: Colors.white),),
            duration: duration,
              backgroundColor: isError ? Colors.red : Colors.green,
            behavior:SnackBarBehavior.floating,
            ),
          );
    
  }
}