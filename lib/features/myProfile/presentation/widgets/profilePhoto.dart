import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    var formattedFarmerName =
        GetStorage().read('farmerName').toString().toUpperCase();
    return buildCircle(
        color: const Color.fromARGB(255, 165, 255, 137),
        all: 30, // Increase the border radius to include the black border
        child: CircleAvatar(
          // maxRadius: 50,
          backgroundColor: Colors.transparent,
          // Set the background to transparent
          child: Text(
            formattedFarmerName.isNotEmpty ? formattedFarmerName[0] : 'AA',
            style: const TextStyle(fontSize: 30.0, color: Colors.blue),
          ),
        ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
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

  Widget buildCircle(
          {required Widget child, required double all, Color? color}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
