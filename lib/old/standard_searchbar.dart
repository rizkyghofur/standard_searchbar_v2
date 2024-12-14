library standard_searchbar;

import 'package:flutter/material.dart';
import 'package:standard_searchbar_v2/old/standard_icon.dart';
import 'package:standard_searchbar_v2/old/standard_suggestions_box.dart';
import 'package:standard_searchbar_v2/old/standard_text_field.dart';

class StandardSearchBar extends StatefulWidget {
  const StandardSearchBar({
    super.key,
    this.width,
    this.height = 50,
    this.borderRadius = 25,
    this.backgroundColor = Colors.white,
    this.hintText = 'Search',
    this.hintStyle = const TextStyle(color: Colors.grey),
    this.startIcon = Icons.search,
    this.startIconColor = Colors.grey,
    this.endIcon = Icons.mic,
    this.endIconColor = Colors.grey,
    this.showStartIcon = true,
    this.showEndIcon = false,
    this.cursorColor = Colors.grey,
    this.startIconSplashColor,
    this.startIconOnTap,
    this.endIconOnTap,
    this.endIconSplashColor,
    this.startIconSize = 20,
    this.endIconSize = 20,
    this.horizontalPadding = 10,
    this.startIconPaddingRight = 8,
    this.endIconPaddingLeft = 8,
    this.onSubmitted,
    this.onChanged,
    this.shadow = const [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
    this.textStyle = const TextStyle(color: Colors.black),
    this.suggestions,
    this.suggestionsBoxHeight = 175,
    this.suggestionsBoxPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.suggestionTextStyle = const TextStyle(fontSize: 16),
    this.maxSuggestions = 10,
    this.suggestionHoverColor,
    this.suggestionHighlightColor,
    this.suggestionDecoration,
  });

  /// The width of the search bar. By default is the width of the parent (expanded).
  final double? width;

  /// The height of the search bar. By default is 50.
  final double height;

  /// The border radius of the search bar. By default is 25 (rounded), but it can be
  /// any value.
  final double borderRadius;

  /// The background color of the search bar. By default is white.
  final Color backgroundColor;

  /// The hint text of the SearchBar. By default is 'Search'.
  final String hintText;

  /// The hint text style of the SearchBar. By default is grey.
  final TextStyle hintStyle;

  /// The start icon of the SearchBar. By default is Icons.search.
  final IconData startIcon;

  /// The color of the start icon. By default is grey.
  final Color startIconColor;

  /// The end icon of the SearchBar. By default is Icons.mic.
  final IconData endIcon;

  /// The color of the end icon. By default is grey.
  final Color endIconColor;

  /// Whether to show the start icon or not. By default is true. If false, the
  /// start icon will not be shown and the icon padding will be removed.
  final bool showStartIcon;

  /// Whether to show the end icon or not. By default is false. If true, the
  /// end icon will be shown and the icon padding will be removed.
  final bool showEndIcon;

  /// The color of the cursor. By default is grey.
  final Color cursorColor;

  /// The splash color of the start icon. The splash color is the color that
  /// appears when the icon is tapped. By default is null, because it is calculated
  /// automatically by the Material widget.
  final Color? startIconSplashColor;

  /// The function callback of the startIcon. If it is not null, the end icon will
  /// be clickable and the splash color will be shown. By default is null.
  final Function()? startIconOnTap;

  /// The function callback of the endIcon. If it is not null, the end icon will
  /// be clickable and the splash color will be shown. By default is null.
  final Function()? endIconOnTap;

  /// The splash color of the end icon. The splash color is the color that
  /// appears when the icon is tapped. By default is null, because it is calculated
  /// automatically by the Material widget.
  final Color? endIconSplashColor;

  /// The size of the start icon. By default is 20.
  final double startIconSize;

  /// The size of the end icon. By default is 20.
  final double endIconSize;

  /// The horizontal padding of the search bar. By default is 10.
  final double horizontalPadding;

  /// The right padding of the start icon. By default is 8.
  final double startIconPaddingRight;

  /// The left padding of the end icon. By default is 8.
  final double endIconPaddingLeft;

  /// The function callback of the TextField onSubmitted. By default is null.
  /// This function can be used to search the text with the given value. This
  /// function is called when the user presses the enter key.
  final Function(String)? onSubmitted;

  /// The function callback of the TextField onChanged. By default is null.
  /// This function is executed every time the text changes. So it can be
  /// execute a search every time the user types a letter or it can be used
  /// to update the search suggestions.
  final Function(String)? onChanged;

  /// The shadow of the search bar. By default is a little black shadow. It
  /// can be any value. A list of BoxShadow.
  final List<BoxShadow> shadow;

  /// The text style of the TextField. By default the text color is black.
  final TextStyle textStyle;

  /// The suggestions of the search bar. By default is null. It can be any
  /// value. A list of String.
  final List<String>? suggestions;

  /// The height of the suggestions box. By default is 175.
  final double? suggestionsBoxHeight;

  /// The padding of the suggestions box. By default is symetric horizontal 16
  /// and vertical 12.
  final EdgeInsetsGeometry? suggestionsBoxPadding;

  /// The text style of the suggestions. By default the text color is fontsize is 16.
  final TextStyle? suggestionTextStyle;

  /// The max number of suggestions to show. If null, all the suggestions will
  /// be shown. By default is 10.
  final int? maxSuggestions;

  /// The color of the suggestions when hovered. By default is transparent.
  final Color? suggestionHoverColor;

  /// The color of the suggestions when highlighted. By default is opaque black.
  final Color? suggestionHighlightColor;

  /// The decoration of the suggestions. By default is null.
  final Decoration? suggestionDecoration;

  @override
  State<StandardSearchBar> createState() => _StandardSearchBarState();
}

class _StandardSearchBarState extends State<StandardSearchBar> {
  bool isSearchBarFocused = false;
  final TextEditingController controller = TextEditingController();
  List<String>? suggestions;

  OverlayEntry? entry;
  final layerLink = LayerLink();
  final unfocus = [false, false];

  @override
  void initState() {
    super.initState();
    suggestions = widget.suggestions;
  }

  void updateSuggestions(String value) {
    // Null safety
    if (widget.suggestions == null) return;

    if (value.isEmpty) {
      setState(() => suggestions = widget.suggestions ?? []);
      updateOverlay();
      return;
    }

    setState(() {
      suggestions = widget.suggestions!
          .where((element) => isSimilar(element, value))
          .toList();
      suggestions = orderContains(suggestions!, value);
      suggestions = orderStartsWith(suggestions!, value);
      suggestions = removeDuplicates(suggestions!);
    });

    updateOverlay();
  }

  bool isSimilar(String original, String searchValue) {
    String originalLower = original.toLowerCase();
    String searchValueLower = searchValue.toLowerCase();

    if (originalLower.contains(searchValueLower)) return true;

    int similarCharactersCount = 0;
    for (var char in searchValueLower.runes) {
      if (originalLower.runes.contains(char)) {
        similarCharactersCount++;
      }
    }

    return similarCharactersCount >= searchValueLower.length / 1.25; // 2
  }

  List<String> orderContains(List<String> suggestions, String value) {
    suggestions.sort((a, b) {
      if (a.contains(value) && !b.contains(value)) {
        return -1;
      } else if (!a.contains(value) && b.contains(value)) {
        return 1;
      } else {
        return 0;
      }
    });
    return suggestions;
  }

  List<String> orderStartsWith(List<String> suggestions, String value) {
    suggestions.sort((a, b) {
      if (a.startsWith(value) && !b.startsWith(value)) {
        return -1;
      } else if (!a.startsWith(value) && b.startsWith(value)) {
        return 1;
      } else {
        return 0;
      }
    });
    return suggestions;
  }

  List<String> removeDuplicates(List<String> suggestions) {
    return suggestions.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (e) {
        if (suggestions == null) return;
        if (isSearchBarFocused) return;
        unfocus[1] = false;
        focus();
        showOverlay();
      },
      onTapOutside: (e) {
        unfocus[1] = true;
        requestUnFocus(1);
      },
      child: CompositedTransformTarget(
        link: layerLink,
        child: Container(
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: isSearchBarFocused
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius),
                    topRight: Radius.circular(widget.borderRadius),
                  )
                : BorderRadius.circular(widget.borderRadius),
            boxShadow: widget.shadow,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
            child: Row(
              children: [
                if (widget.showStartIcon != false)
                  StandardIcon(
                    icon: widget.startIcon,
                    iconColor: widget.startIconColor,
                    iconSize: widget.startIconSize,
                    iconSplashColor: widget.startIconSplashColor,
                    iconPaddingRight: widget.startIconPaddingRight,
                    iconOnTap: widget.startIconOnTap,
                  ),
                Expanded(
                  child: StandardTextField(
                    showEndIcon: widget.showEndIcon,
                    endIconPaddingLeft: widget.endIconPaddingLeft,
                    hintText: widget.hintText,
                    hintStyle: widget.hintStyle,
                    cursorColor: widget.cursorColor,
                    textStyle: widget.textStyle,
                    controller: controller,
                    onSubmitted: widget.onSubmitted,
                    onChanged: widget.onChanged,
                    horizontalPadding: widget.horizontalPadding,
                    updateSuggestions: updateSuggestions,
                  ),
                ),
                if (widget.showEndIcon != false)
                  StandardIcon(
                    icon: widget.endIcon,
                    iconColor: widget.endIconColor,
                    iconSize: widget.endIconSize,
                    iconSplashColor: widget.endIconSplashColor,
                    iconPaddingLeft: widget.endIconPaddingLeft,
                    iconOnTap: widget.endIconOnTap,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showOverlay() {
    if (widget.suggestions == null) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 16,
        width: size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: StandardSuggestionsBox(
            suggestions: suggestions!
                .take(widget.maxSuggestions ?? suggestions!.length)
                .toList(),
            borderRadius: widget.borderRadius,
            backgroundColor: widget.backgroundColor,
            boxHeight: widget.suggestionsBoxHeight!,
            boxPadding: widget.suggestionsBoxPadding!,
            suggestionTextStyle: widget.suggestionTextStyle!,
            hoverColor: widget.suggestionHoverColor,
            highlightColor: widget.suggestionHighlightColor,
            decoration: widget.suggestionDecoration,
            onSuggestionSelected: (s) {
              controller.text = s;
              widget.onSubmitted?.call(s);
              unFocus();
            },
            onTapInside: (e) {
              unfocus[0] = false;
            },
            onTapOutside: (e) {
              unfocus[0] = true;
              Future.delayed(
                  const Duration(milliseconds: 100), () => requestUnFocus(0));
            },
          ),
        ),
      ),
    );

    overlay.insert(entry!);
  }

  void updateOverlay() {
    if (widget.suggestions == null) return;
    if (!isSearchBarFocused) return;
    entry?.markNeedsBuild();
  }

  void requestUnFocus(int n) {
    if (unfocus[0] && unfocus[1]) {
      unFocus();
      unfocus[0] = false;
      unfocus[1] = false;
    }
  }

  void focus() {
    if (widget.suggestions == null) return;
    setState(() => isSearchBarFocused = true);
  }

  void unFocus() {
    if (widget.suggestions == null) return;
    if (!isSearchBarFocused) return;
    setState(() => isSearchBarFocused = false);
    entry?.remove();
  }
}
