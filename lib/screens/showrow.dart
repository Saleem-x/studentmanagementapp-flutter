import 'package:flutter/material.dart';

class Showrow extends StatelessWidget {
  final String title;
  final String value;
  const Showrow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        const Text(':',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        Text(value,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}
