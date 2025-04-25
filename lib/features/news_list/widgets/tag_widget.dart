import 'package:flutter/material.dart';
import 'package:news_app/repositories/news_list/models/tag.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.tags,
  });

  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 12,
        children: tags.map((tag) {
          return Chip(
            label: Text(tag.name),
            backgroundColor: Color(_hexToColor(tag.color)),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide.none,
            ),
          );
        }).toList());
  }
}

int _hexToColor(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  return int.parse("FF$hexColor", radix: 16);
}
