import 'package:flutter/material.dart';
import 'button_filter.dart';

class GridFilterButtons extends StatelessWidget {
  final List<bool> filterSelection;
  final Function(int) onFilterButtonTapped;

  const GridFilterButtons({
    super.key,
    required this.filterSelection,
    required this.onFilterButtonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 3.4,
        children: [
          FilterButton(
            buttonText: "Energy Sensor",
            icon: Icons.bolt_outlined,
            isSelected: filterSelection[0],
            onTap: () => onFilterButtonTapped(0),
          ),
          FilterButton(
            buttonText: "Vibration Sensor",
            icon: Icons.vibration_outlined,
            isSelected: filterSelection[1],
            onTap: () => onFilterButtonTapped(1),
          ),
          FilterButton(
            buttonText: "Alert",
            icon: Icons.warning,
            isSelected: filterSelection[2],
            onTap: () => onFilterButtonTapped(2),
          ),
          FilterButton(
            buttonText: "Operating",
            icon: Icons.check_circle,
            isSelected: filterSelection[3],
            onTap: () => onFilterButtonTapped(3),
          ),
        ],
      ),
    );
  }
}
