import 'package:flutter/material.dart';
import 'package:style_gallery/theme/app_theme.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
        dismissDirection: DismissDirection.up,
        backgroundColor: AppTheme.primary,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
