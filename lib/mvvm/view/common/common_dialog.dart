import 'package:flutter/material.dart';

showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required ValueChanged onConfirmed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => ConfirmDialog(
      title: title,
      content: content,
      onConfirmed: onConfirmed,
    ),
  );
}

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final ValueChanged<bool> onConfirmed;

  // ignore: use_key_in_widget_constructors
  const ConfirmDialog({
    required this.title,
    required this.content,
    required this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        //Flutter2.0以降はFlatButtonがTextButtonに
        TextButton(
          child: const Text("S.of(context).yes"),
          onPressed: () {
            Navigator.pop(context);
            onConfirmed(true);
          },
        ),
        TextButton(
          child: const Text("S.of(context).dialog_button"),
          onPressed: () {
            // ダイアログはNavigatorでCloseすること
            Navigator.pop(context);
            onConfirmed(false);
          },
        ),
      ],
    );
  }
}
