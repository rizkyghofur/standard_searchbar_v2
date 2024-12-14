import 'package:flutter/material.dart';
import 'package:standard_searchbar_v2/new/standard_icons.dart';
import 'package:standard_searchbar_v2/new/standard_search_anchor.dart';
import 'package:standard_searchbar_v2/new/standard_search_controller.dart';

class StandardSearchBar extends StatefulWidget {
  const StandardSearchBar({
    super.key,
    this.width,
    this.height = 56,
    this.constraints = const BoxConstraints(maxWidth: 720),
    this.padding = EdgeInsets.zero,
    this.borderRadius = 28,
    this.bgColor = Colors.white,
    this.leading = const StandardIcons(
      icons: [
        Icon(Icons.search, size: 24, color: Colors.grey),
      ],
    ),
    this.trailing,
  });

  final double? width;
  final double height;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color bgColor;

  final StandardIcons leading;
  final StandardIcons? trailing;

  static StandardSearchAnchorState? of(BuildContext context) {
    return context.findAncestorStateOfType<StandardSearchAnchorState>();
  }

  @override
  State<StandardSearchBar> createState() => StandardSearchBarState();
}

class StandardSearchBarState extends State<StandardSearchBar> {
  StandardSearchController? controller;

  @override
  void initState() {
    super.initState();
    controller = StandardSearchBar.of(context)?.controller;
    controller?.searchBar = this;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      constraints: widget.constraints,
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: getBorderRadius(),
        color: widget.bgColor,
      ),
      child: Row(
        children: [
          widget.leading,
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }

  BorderRadiusGeometry getBorderRadius() {
    assert(controller != null);
    if (controller!.isOpen) {
      return BorderRadius.only(
        topLeft: Radius.circular(widget.borderRadius),
        topRight: Radius.circular(widget.borderRadius),
      );
    } else {
      return BorderRadius.all(
        Radius.circular(widget.borderRadius),
      );
    }
  }
}
