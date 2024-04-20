import 'package:flutter/material.dart';

class OrderTextField extends StatefulWidget {
  const OrderTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines = 1,
    required this.validationMessage,
    this.isObscureText = false,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onTap;
  final int maxLines;
  final int minLines;
  final String validationMessage;
  final bool isObscureText;
  final bool readOnly;

  @override
  State<OrderTextField> createState() => _OrderTextFieldState();
}

class _OrderTextFieldState extends State<OrderTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: InkWell(
          onTap: widget.onTap,
          child: Icon(widget.suffixIcon),
        ),
      ),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      obscureText: widget.isObscureText,
      readOnly: widget.readOnly,
      validator: (value) {
        if (value!.isEmpty) {
          return widget.validationMessage;
        }
        return null;
      },
    );
  }
}
