import 'package:flutter/material.dart';

class RecentSearches extends StatelessWidget {
  final List<String> recentSearches;
  final void Function(String) onRemoveTerm;
  final VoidCallback onClearAll;

  const RecentSearches({
    super.key,
    required this.recentSearches,
    required this.onRemoveTerm,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onClearAll,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: recentSearches
              .map(
                (term) => Chip(
                  label: Text(term),
                  deleteIcon:
                      const Icon(Icons.close, size: 16, color: Colors.grey),
                  onDeleted: () => onRemoveTerm(term),
                  backgroundColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
