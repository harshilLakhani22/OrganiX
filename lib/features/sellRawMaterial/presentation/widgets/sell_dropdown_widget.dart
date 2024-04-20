import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sellRawMaterialController.dart';

class SellDropDownMenu extends StatefulWidget {
  const SellDropDownMenu({super.key, required this.controller});

  final SellRawMaterialController controller;


  @override
  State<SellDropDownMenu> createState() => _SellDropDownMenuState();
}

class _SellDropDownMenuState extends State<SellDropDownMenu> {
  String dropdownvalue = 'strAnimalDung'.tr;

  // List of items in our dropdown menu
  var items = [
    'strAnimalDung'.tr,
    'strCropWastage'.tr,
    'strAnimalUrine'.tr,
    'strUselessGrass'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      child: DropdownButton(
        value: dropdownvalue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });

          widget.controller.setRawMaterialType(dropdownvalue); // Update controller's rawMaterialType
        },
      ),
    );
  }
}
