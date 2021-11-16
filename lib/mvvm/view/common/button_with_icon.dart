import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonWithIcon extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  final String label;

  ButtonWithIcon({
    required this.iconData,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    //Flutter2.0以降はRaisedButton非推奨に => ElevatedButtonに
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      icon: FaIcon(iconData), // FontAwesomeをライブラリを使うことで簡単に使用できる
      label: Text(label),
    );
    // return RaisedButton.icon(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(8.0),
    //   ),
    //   onPressed: onPressed,
    //   icon: FaIcon(iconData),
    //   label: Text(label),
    // );
  }
}
