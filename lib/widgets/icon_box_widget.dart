import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconBoxWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  const IconBoxWidget(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        color: Colors.white,
        child: IconButton(
          onPressed: onPressed,
          icon: FaIcon(
            icon,
            color: color,
            size: 30,
          ),
        ),
      ),
    );
  }
}
