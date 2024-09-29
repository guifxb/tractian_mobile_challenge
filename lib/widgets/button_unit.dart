import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/colors.dart';

class UnitButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const UnitButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundButton,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Image.asset(
                'lib/assets/images/icon_button_company.png',
                height: 40,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

