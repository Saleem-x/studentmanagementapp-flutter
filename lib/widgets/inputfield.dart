import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputfieldWidget extends StatelessWidget {
  TextEditingController inputcontroller;
  String label;
  TextInputType type;
  bool ispassword = false;

  InputfieldWidget(
      {super.key,
      required this.inputcontroller,
      required this.label,
      required this.type,
      bool? ispass}) {
    ispassword = ispass ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Material(
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please enter $label ';
            } else {
              return null;
            }
          },
          obscureText: ispassword,
          keyboardType: type,
          controller: inputcontroller,
          decoration: InputDecoration(
              label: Text(label),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}
