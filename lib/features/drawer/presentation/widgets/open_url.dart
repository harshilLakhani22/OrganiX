import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:url_launcher/url_launcher.dart';

void openUrl(String url) async {
  Uri uri = Uri.parse(url); // Convert the String URL to a Uri object

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showToast(title: 'Error', subTitle: 'Could not launch $url');
  }
}
