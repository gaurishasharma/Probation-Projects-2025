import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSubmitted;
  final VoidCallback onFilterPressed;

  const SearchHeader({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => onSubmitted(controller.text),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          icon: const Icon(Icons.tune),
          onPressed: onFilterPressed,
        ),
      ],
    );
  }
}
