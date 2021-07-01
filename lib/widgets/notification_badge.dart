import 'dart:math' as math;
import 'package:flutter/material.dart';

class NotificationNumberBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var rand = math.Random();
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.brightness_1,
          color: Colors.pink.shade600,
          size: 25,
        ),
        Text(
          rand.nextInt(20).toString(),
          style: const TextStyle(
            fontSize: 12.5,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
