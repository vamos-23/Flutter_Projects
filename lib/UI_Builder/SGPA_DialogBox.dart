import 'package:flutter/material.dart';
class SGPA_DialogBox{
  static void sgpaDialogBox(BuildContext context,double s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.lightGreenAccent,
        title: Center(
          child: Text(
            'Your Calculated SGPA:',
            style: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 3.0),
        content: SizedBox(
          height: 55,
          width: 65,
          child: Center(
            child: Text(
              s.toStringAsFixed(2),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}