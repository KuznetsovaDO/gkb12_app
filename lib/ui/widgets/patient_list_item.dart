import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPatientistItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressedButton1;
  final VoidCallback onPressedButton2;

  const CustomPatientistItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onPressedButton1,
    required this.onPressedButton2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star),
          SizedBox(height: 4),
          Icon(Icons.favorite),
        ],
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: onPressedButton1,
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: onPressedButton2,
          ),
        ],
      ),
    );
  }
}
