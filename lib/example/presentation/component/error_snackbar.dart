import 'package:flutter/material.dart';

// エラーメッセージを表示するSnackBar
class ErrorSnackBar {
  final String message;

  ErrorSnackBar({required this.message});
  // buildメソッドでSnackBarを返す
  SnackBar build() {
    return SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    );
  }
}
