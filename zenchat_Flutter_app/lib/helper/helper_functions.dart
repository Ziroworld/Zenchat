import 'package:flutter/material.dart';

// error message display to user

void displayMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Text(message),
      ),
    );
}
