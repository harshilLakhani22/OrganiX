import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/local_languages/languages.dart';
import 'package:organix/core/utils/constants/sizes.dart';

void buildLanguageDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(
            'strChooseYourLanguage'.tr,
            style: const TextStyle(
              fontSize: MSizes.mdlg,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Text(
                      locales[index]['name'],
                      style: const TextStyle(
                        fontSize: MSizes.md,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    onTap: () {
                      updateLanguage(locales[index]['locale']);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Color(0xff688656),
                  thickness: 2,
                );
              },
              itemCount: locales.length,
            ),
          ),
        );
      });
}

updateLanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
}
