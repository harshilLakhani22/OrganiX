import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:organix/routes/app_routes.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user == null) {
      Timer(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.login);
      });
    } else {
      Timer(
        const Duration(seconds: 3),
        () {
          Get.offAllNamed(AppRoutes.dashboard);
        },
      );
    }
  }
}
