import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final IconData icon;
  final bool isSelected;

  const FilterButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 2,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
