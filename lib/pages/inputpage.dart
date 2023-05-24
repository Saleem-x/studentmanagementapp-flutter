import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/models/db_models.dart';
import 'package:student_management/widgets/inputfield.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  File? _image;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _stdController = TextEditingController();
  final _phoneController = TextEditingController();

  final form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: form_key,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 60,
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(60),
                          child: (_image != null)
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset('assets/images/person.jpg'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InputfieldWidget(
                      inputcontroller: _nameController,
                      label: 'Name',
                      type: TextInputType.name),
                  InputfieldWidget(
                      inputcontroller: _ageController,
                      label: 'Age',
                      type: TextInputType.number),
                  InputfieldWidget(
                      inputcontroller: _stdController,
                      label: 'class',
                      type: TextInputType.name),
                  InputfieldWidget(
                      inputcontroller: _phoneController,
                      label: 'Phone',
                      type: TextInputType.number),
                  Column(
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                            child: const Text('submit'),
                            onPressed: () {
                              if (form_key.currentState!.validate()) {
                                form_key.currentState!.save();
                                StudentModel student = StudentModel(
                                    name: _nameController.text,
                                    age: _ageController.text,
                                    std: _stdController.text,
                                    phone: _phoneController.text,
                                    id: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    imgpath: _image?.path ?? 'no-img')  ;
                                addStudent(student);
                                Navigator.of(context).pop();
                                getalldata();
                              }
                            }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        _image = File(imagePicked.path);
      });
    }
  }
}
