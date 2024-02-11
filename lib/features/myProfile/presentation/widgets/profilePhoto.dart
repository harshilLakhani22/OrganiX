import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/features/myProfile/presentation/controller/myProfileController.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({Key? key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final MyProfileController controller = Get.find<MyProfileController>();

    return Center(
      child: Stack(
        children: [
          _buildImage(controller),
          Positioned(
            bottom: 0,
            right: 4,
            child: _buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(MyProfileController controller) {
    var formattedFarmerName = controller.farmerName.toString().toUpperCase();
    final imagePath = controller.profileImagePath;

    return buildCircle(
      color: const Color.fromARGB(255, 165, 255, 137),
      all: 30,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: imagePath != null
            ? Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : Text(
                formattedFarmerName.isNotEmpty ? formattedFarmerName[0] : 'AA',
                style: const TextStyle(fontSize: 30.0, color: Colors.blue),
              ),
      ),
    );
  }

  Widget _buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.photo_camera,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    Color? color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
