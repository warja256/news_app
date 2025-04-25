import 'package:flutter/material.dart';

class ReactionWidget extends StatelessWidget {
  const ReactionWidget({
    super.key,
    required this.entry,
  });
  final MapEntry<String, int> entry;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        '${entry.key} ${entry.value}',
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
