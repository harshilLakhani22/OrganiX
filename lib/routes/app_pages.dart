import 'package:get/get.dart';
import 'package:organix/features/about_us/pages/about_us_screen.dart';
import 'package:organix/features/auth/presentation/pages/login/login_page.dart';
import 'package:organix/features/auth/presentation/pages/login_with_mobile_number/login_with_mobile_number_page.dart';
import 'package:organix/features/auth/presentation/pages/signup/signup_page.dart';
import 'package:organix/features/auth/presentation/pages/verify_code_page.dart';
import 'package:organix/features/buyJivamrut/presentation/pages/buyJivamrut_page.dart';
import 'package:organix/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:organix/features/myOrder/presentation/pages/order_page.dart';
import 'package:organix/features/myProfile/presentation/pages/myProfile.dart';
import 'package:organix/features/sellRawMaterial/presentation/pages/sellRawMaterial_page.dart';
import 'package:organix/features/splashScreen/presentation/pages/splash_page.dart';
import 'package:organix/routes/app_routes.dart';

class AppPages{
  static List<GetPage> list = [
    GetPage(name: AppRoutes.initialRoute, page: SplashScreen.new),
    GetPage(name: AppRoutes.dashboard, page: DashBoardScreen.new),
    GetPage(name: AppRoutes.login, page: LoginScreen.new),
    GetPage(name: AppRoutes.signUp, page: SignUpScreen.new),
    GetPage(name: AppRoutes.buyJivamrut, page: BuyJivamrutScreen.new),
    GetPage(name: AppRoutes.sellRawMaterial, page: SellRawMaterialScreen.new),
    GetPage(name: AppRoutes.myOrder, page: MyOrderPageScreen.new),
    GetPage(name: AppRoutes.loginWithMobile, page: LoginWithPhoneNumber.new),
    // GetPage(name: AppRoutes.verifyCodeScreen, page: VerifyCodeScreen.new),
    GetPage(name: AppRoutes.myProfile, page: MyProfileScreen.new),
    GetPage(name: AppRoutes.aboutUs, page: AboutUsScreen.new),
  ];
}