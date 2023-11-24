import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    required this.title,
    required this.onTap,
    this.buttonColor = const Color(0xff598216),
    this.textColor = const Color(0xffFFFFFF),
    super.key,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3,
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
