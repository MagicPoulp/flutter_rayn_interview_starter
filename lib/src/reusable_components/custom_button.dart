import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text, required this.backgroundColor, required this.onPressed,
  });
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () { onPressed(); },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          foregroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                  side: BorderSide(color: backgroundColor)
              )
          )
      ),
      child: Text(
        text,
        style: MyTextTheme.buttonsText,
      ),
    );
  }
}
