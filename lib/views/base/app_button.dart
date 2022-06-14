import 'package:flutter/material.dart';
import 'package:shelbi_finance/constants/app_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColor.black,
            ),
          ),
        ],
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          color: AppColor.black,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.all(14),
      ),
    );
  }
}
