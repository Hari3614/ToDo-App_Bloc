import 'package:flutter/material.dart';

import 'package:todo_bloc/constant/constants.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    required this.onPressedName,
    required this.onPressed,
  }) : super(key: key);

  final String onPressedName;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black)),
      onPressed: onPressed,
      child: Text(
        onPressedName,
        style: buttonStyle,
      ),
    );
  }
}
