import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';

class MAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MAuthAppBar({
    super.key,
    required this.title,
    this.color = Colors.white,
    this.showBackArrow = false,
  });

  final String title;
  final bool showBackArrow;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.tr,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: MSizes.lg,
        ),
      ),
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
              ),
            )
          : null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: MColors.appBar,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(MDeviceUtility.getAppBarHeight());
}
