import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.hint,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.onTap,
    this.onChanges,
    this.suffixIcon,
    this.fillColor,
    this.textInputFormatter,
    this.validationMessage,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String? hint;
  final bool isObscureText;
  final IconData? icon;
  final Function()? onTap;
  final Function(String)? onChanges;
  final TextInputType? keyboardType;
  final String? suffixIcon;
  final Color? fillColor;
  final List<TextInputFormatter>? textInputFormatter;
  final String? validationMessage;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      scrollPadding: const EdgeInsets.only(bottom: 40),
      textCapitalization: TextCapitalization.sentences,
      inputFormatters: widget.textInputFormatter,
      obscureText: widget.isObscureText,
      focusNode: _focus,
      style: TextStyle(
        color: (Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFFffffff)
            : const Color(0xFF000000)),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      cursorColor: (Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFFffffff)
          : const Color(0xFF000000)),
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanges,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: widget.fillColor ?? const Color(0xFFffffff).withOpacity(0.15),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x00ffffff)),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x00ffffff)),
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: widget.suffixIcon != null || widget.icon != null
            ? UnconstrainedBox(
          child: InkWell(
            onTap: widget.onTap,
            child: widget.icon != null
                ? Icon(
              widget.icon,
              size: 24,
              color: _focus.hasFocus
                  ? const Color(0xFF4CB474)
                  : const Color(0xFFB9BABA),
            )
                : Image.asset(
              widget.suffixIcon!,
              height: 24,
              width: 24,
              color: _focus.hasFocus
                  ? const Color(0xFF4CB474)
                  : const Color(0xFFB9BABA),
            ),
          ),
        )
            : null,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        isDense: true,
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: (Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFFffffff)
              : const Color(0xFFB9BABA)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty && widget.validationMessage != null) {
          return widget.validationMessage;
        }
        return null;
      },
    );
  }
}
