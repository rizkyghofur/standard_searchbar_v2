import 'package:flutter/material.dart';

class StandardIcon extends StatelessWidget {
  const StandardIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    this.iconSplashColor,
    this.iconOnTap,
    this.iconPaddingLeft,
    this.iconPaddingRight,
  });

  /// The Icon to display.
  final IconData icon;

  /// The color of the Icon.
  final Color iconColor;

  /// The size of the Icon.
  final double iconSize;

  /// The splash color of the Icon.
  final Color? iconSplashColor;

  /// The callback function when the Icon is tapped.
  final Function()? iconOnTap;

  /// The left padding of the Icon.
  final double? iconPaddingLeft;

  /// The right padding of the Icon.
  final double? iconPaddingRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: iconPaddingLeft ?? 0, right: iconPaddingRight ?? 0),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: iconSplashColor,
            onTap: iconOnTap,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
