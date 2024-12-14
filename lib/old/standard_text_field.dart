import 'package:flutter/material.dart';

class StandardTextField extends StatelessWidget {
  const StandardTextField({
    super.key,
    required this.showEndIcon,
    required this.endIconPaddingLeft,
    required this.hintText,
    required this.hintStyle,
    required this.cursorColor,
    required this.textStyle,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    required this.horizontalPadding,
    required this.updateSuggestions,
  });

  final bool showEndIcon;
  final double endIconPaddingLeft;
  final String hintText;
  final TextStyle hintStyle;
  final Color cursorColor;
  final TextStyle textStyle;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final double horizontalPadding;
  final Function(String) updateSuggestions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: showEndIcon
          ? EdgeInsets.zero
          : EdgeInsets.only(
              right: endIconPaddingLeft,
            ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: hintStyle,
        ),
        cursorColor: cursorColor,
        style: textStyle,
        onSubmitted: onSubmitted,
        onChanged: (value) {
          updateSuggestions(value);
          if (onChanged != null) {
            onChanged!(value);
          }
        },
      ),
    );
  }
}
