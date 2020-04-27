import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({
    @required this.text,
    @required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

        ),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Color(0xff00CCFF),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Color(0xFF1E3C44),
              letterSpacing: 0,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }
}