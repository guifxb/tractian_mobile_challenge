import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onSearchQueryChanged;

  const CustomSearchBar({super.key, this.onSearchQueryChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        labelText: "Search location or asset",
        border: OutlineInputBorder(),
      ),
      onChanged: onSearchQueryChanged,
    );
  }
}
