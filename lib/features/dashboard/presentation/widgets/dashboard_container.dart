
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';

class DashBoardContainer extends StatelessWidget {
  const DashBoardContainer({
    super.key,
    required this.img,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.buttonName,
  });

  final String img;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(MSizes.mdlg),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.fill,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(MSizes.borderRadiusLg),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Title text
            Padding(
              padding: const EdgeInsets.all(MSizes.mdlg),
              child: Text(
                title.tr,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Divider
            const Divider(
              color: MColors.secondary,
              thickness: 2,
              endIndent: 20,
              indent: 20,
            ),
            const SizedBox(height: MSizes.defaultSpace),
            Text(
              subTitle.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: MSizes.mdlg,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: MSizes.defaultSpace),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xff142814)),
              child: Text(
                buttonName.tr,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
