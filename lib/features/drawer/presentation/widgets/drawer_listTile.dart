import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
    this.color = const Color(0xff598216),
  });

  final IconData leadingIcon;
  final String title;
  final Function onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title.tr),
      leading: Icon(leadingIcon, color: color,),
      onTap: () => onTap(),
    );
  }
}
