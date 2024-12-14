import 'package:flutter/material.dart';
import 'package:standard_searchbar_v2/new/standard_search_bar.dart';
import 'package:standard_searchbar_v2/new/standard_search_controller.dart';
import 'package:standard_searchbar_v2/new/standard_suggestions.dart';

/// If there is no StandardSearchController passed in the constructor of
/// StandardSearchBar, then a default one will be created.
class StandardSearchAnchor extends StatefulWidget {
  const StandardSearchAnchor({
    super.key,
    this.controller,
    required this.searchBar,
    required this.suggestions,
  });

  static late StandardSearchAnchorState state;

  final StandardSearchController? controller;

  final StandardSearchBar searchBar;
  final StandardSuggestions suggestions;

  @override
  // ignore: no_logic_in_create_state
  State<StandardSearchAnchor> createState() {
    state = StandardSearchAnchorState();
    return state;
  }
}

class StandardSearchAnchorState extends State<StandardSearchAnchor> {
  late final StandardSearchController controller;
  final layerLink = LayerLink();
  OverlayEntry? entry;

  bool get isOpen => entry != null;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = StandardSearchController();
    }
    controller.anchor = this;
    StandardSuggestions.controller = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (e) {
        StandardSearchController.unfocus[1] = false;
        controller.open();
      },
      onTapOutside: (e) {
        StandardSearchController.unfocus[1] = true;
        controller.requestClose();
      },
      child: CompositedTransformTarget(
        link: layerLink,
        child: widget.searchBar,
      ),
    );
  }

  void open() {
    if (entry != null) return;
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(builder: (_) {
      return Positioned(
        left: offset.dx,
        top: offset.dy + renderBox.size.height + 16,
        width: renderBox.size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, renderBox.size.height),
          child: widget.suggestions,
        ),
      );
    });
    Overlay.of(context).insert(entry!);
  }

  void close() {
    if (entry != null) {
      entry!.remove();
      entry = null;
    }
  }

  void clear() {
    controller.clear();
  }
}
