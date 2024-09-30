import 'package:flutter/material.dart';

class SensorIcon extends StatelessWidget {
  final String sensorType;

  const SensorIcon({super.key, required this.sensorType});

  @override
  Widget build(BuildContext context) {
    switch (sensorType) {
      case "energy":
        return const Icon(Icons.bolt_outlined, color: Colors.green, size: 18);
      case "vibration":
        return const Icon(Icons.vibration_outlined, color: Colors.green, size: 18);
      default:
        return const SizedBox.shrink();
    }
  }
}