import 'package:flutter/material.dart';

class InfoSnackBar extends SnackBar {
  InfoSnackBar({super.key, required this.message}) : super(content: Text(message), behavior: SnackBarBehavior.floating);

  final String message;
}
