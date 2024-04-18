import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/utils/constants/sizes.dart';

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
    return Column(
      children: [
        ListTile(
          title: Text(
            title.tr,
            style: const TextStyle(
                fontSize: MSizes.md, fontWeight: FontWeight.w500),
          ),
          leading: Icon(
            leadingIcon,
            color: color,
          ),
          onTap: () => onTap(),
        ),
        const Divider(
          height: 3,
          thickness: 0.5,
          indent: 10,
          endIndent: 25,
        ),
      ],
    );
  }
}
