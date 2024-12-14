import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:standard_searchbar_v2/new/standard_search_controller.dart';
import 'package:standard_searchbar_v2/new/standard_suggestions.dart';

class StandardSuggestion extends StatefulWidget {
  const StandardSuggestion({
    super.key,
    this.cursor = SystemMouseCursors.basic,
    this.height,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 19,
      vertical: 12,
    ),
    required this.text,
    this.icon,
  });

  final SystemMouseCursor cursor;
  final double? height;
  final EdgeInsetsGeometry padding;
  final String text;
  final IconData? icon;

  @override
  State<StandardSuggestion> createState() => _StandardSuggestionState();
}

class _StandardSuggestionState extends State<StandardSuggestion> {
  StandardSearchController? controller;
  double height = 0;

  @override
  void initState() {
    super.initState();
    controller = StandardSuggestions.controller;
    assert(controller != null);
    if (widget.height == null) {
      height = controller!.searchBar.widget.height;
    } else {
      height = widget.height!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: MouseRegion(
        cursor: widget.cursor,
        child: Container(
          height: height,
          padding: widget.padding,
          child: Row(
            children: [
              if (widget.icon != null)
                const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              if (widget.icon != null) const SizedBox(width: 12),
              Text(widget.text, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
