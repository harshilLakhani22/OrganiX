import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/common/widgets/appbar/auth_appbar.dart';
import 'package:organix/core/utils/constants/sizes.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAuthAppBar(title: 'strAboutUs'.tr, showBackArrow: true,),
      // AppBar(
      //   title: Text("About Us"),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.md),
          child: Column(
            children: [
              Text(
                'strAboutUs1'.tr,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: MSizes.spaceBtwSections,),
              Text(
                'strAboutUs2'.tr,
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: MSizes.spaceBtwSections,),
              Text(
                'strAboutUs3'.tr,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
