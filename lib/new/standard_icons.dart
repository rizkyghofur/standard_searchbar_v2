import 'package:flutter/material.dart';

class StandardIcons extends StatelessWidget {
  const StandardIcons({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.spacing = 16,
    this.icons = const [],
  });

  final EdgeInsetsGeometry padding;
  final double spacing;
  final List<Widget> icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: getChildren(),
      ),
    );
  }

  List<Widget> getChildren() {
    return List.generate(icons.length, (index) {
      if (index == icons.length - 1) return icons[index];
      return Row(children: [icons[index], SizedBox(width: spacing)]);
    });
  }
}
