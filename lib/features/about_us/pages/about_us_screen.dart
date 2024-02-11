import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text('strAboutUs1'.tr, style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              Text('strAboutUs2'.tr, style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              Text('strAboutUs3'.tr, style: TextStyle(fontSize: 18),),
            ],
          ),
        ),
      ),
    );
  }
}
