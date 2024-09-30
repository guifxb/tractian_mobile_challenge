import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  final String status;

  const StatusIcon({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == "alert") {
      return const Icon(Icons.warning, color: Colors.red, size: 16);
    }
    return const SizedBox.shrink();
  }
}
