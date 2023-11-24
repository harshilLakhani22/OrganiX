import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.onPressed,
    this.titleImage,
    this.title,
    this.margin,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.isLarge = false,
    this.backgroundColor,
    this.foregroundColor,
    Key? key,
  }) : super(key: key);

  final String? titleImage;
  final String? title;
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool isLarge;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (margin != null) ? margin : EdgeInsets.zero,
      child: isLarge
          ? Row(children: [Expanded(child: getElevatedButton())])
          : getElevatedButton(),
    );
  }

  Widget getElevatedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Color(0xff598216),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 100),
        ),
        padding:
        padding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        alignment: Alignment.center,
      ),
      onPressed: onPressed,
      child: title != null
          ? Text(
        title!,
        style: textStyle ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      )
          : Image.asset(
        titleImage!,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        height: 30,
        width: 30,
      ),
    );
  }
}
