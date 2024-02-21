import 'package:flutter/material.dart';
import 'package:swift_street/Widgets/input_field.dart';

Widget locationInput({
  required String hintText,
  required TextEditingController controller,
  required double width,
  required IconData icon,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: Colors.black,
        size: 20.0,
      ),
      const SizedBox(width: 10),
      SizedBox(
        width: width,
        height: 50,
        child: InputField(
          hintText: hintText,
          controller: controller,
          args: {
            'keyboardType': TextInputType.streetAddress,
            'contentPadding': const EdgeInsets.all(10.0),
            'alignment': TextAlign.start,
            'hintSize': 18.0,
          },
        ),
      )
    ],
  );
}