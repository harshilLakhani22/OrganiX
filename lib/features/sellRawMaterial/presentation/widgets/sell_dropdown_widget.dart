import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownMenuWidget extends StatefulWidget {
  const DropDownMenuWidget({super.key});

  @override
  State<DropDownMenuWidget> createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
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
        },
      ),
    );
  }
}
