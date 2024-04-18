import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/constants/sizes.dart';

class MLoginHeader extends StatelessWidget {
  const MLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(MSizes.spaceBtwSections),
      child: Image(
        image: AssetImage(MImages.imgLoginWithMobile),
        height: 200,
      ),
    );
  }
}