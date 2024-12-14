import 'package:flutter/material.dart';
import 'package:standard_searchbar_v2/new/standard_search_controller.dart';
import 'package:standard_searchbar_v2/new/standard_suggestion.dart';

class StandardSuggestions extends StatefulWidget {
  const StandardSuggestions({
    super.key,
    required this.suggestions,
  });

  static late StandardSearchController controller;
  final List<StandardSuggestion> suggestions;

  @override
  State<StandardSuggestions> createState() => StandardSuggestionsState();
}

class StandardSuggestionsState extends State<StandardSuggestions> {
  StandardSearchController? controller;

  @override
  void initState() {
    super.initState();
    controller = StandardSuggestions.controller;
    controller?.suggestions = this;
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (e) {
        StandardSearchController.unfocus[0] = false;
      },
      onTapOutside: (e) {
        StandardSearchController.unfocus[0] = true;
        controller?.requestClose();
      },
      child: Container(
        decoration: BoxDecoration(
          color: controller?.searchBar.widget.bgColor,
          borderRadius: getBorderRadius(),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: getBorderRadius(),
          child: Column(
            children: widget.suggestions,
          ),
        ),
      ),
    );
  }

  BorderRadiusGeometry getBorderRadius() {
    double radius = controller?.searchBar.widget.borderRadius ?? 16;
    return BorderRadius.only(
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
  }
}
