import 'package:flutter/material.dart';
import 'package:organix/core/utils/constants/colors.dart';
import 'package:organix/core/utils/constants/sizes.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    required this.title,
    required this.onTap,
    this.buttonColor = MColors.primary,
    this.textColor = const Color(0xffFFFFFF),
    super.key,
    this.isLoading = false,
    this.isBorder = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isBorder;
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
          border: isBorder ? Border.all(color: MColors.black) : null,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: MSizes.mdlg
                  ),
                ),
        ),
      ),
    );
  }
}
