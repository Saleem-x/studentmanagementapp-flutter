import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management/screens/homescreen.dart';
import 'package:student_management/screens/showrow.dart';

class Detailedview extends StatelessWidget {
  String name;
  String age;
  String std;
  String phone;
  String? imagepath;
  String id;
  Detailedview({
    super.key,
    required this.name,
    required this.age,
    required this.std,
    required this.phone,
    required this.id,
    this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    File? image;
    if (imagepath != null) {
      image = File(imagepath!);
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 50,
          ),
          CircleAvatar(
            radius: 60,
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(60),
                child: (imagepath != 'no-img')
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset('assets/images/person.jpg'),
              ),
            ),
          ),
          Text(name,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          Showrow(title: 'age', value: age),
          Showrow(title: 'class', value: std),
          Showrow(title: 'phone', value: phone),
          const SizedBox(
            height: 50,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}
