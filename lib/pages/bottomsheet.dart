import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/models/db_models.dart';
import 'package:student_management/widgets/inputfield.dart';

class InputBottomsheet extends StatefulWidget {
  StudentModel student;
  InputBottomsheet({
    required this.student,
    super.key,
  });

  @override
  State<InputBottomsheet> createState() =>
      // ignore: no_logic_in_create_state
      _InputBottomsheetState(student: student);
}

class _InputBottomsheetState extends State<InputBottomsheet> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController stdcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  StudentModel student;
  _InputBottomsheetState({required this.student});

  bool isimage = false;
  File? _image;
  Future<void> pickImage() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_image != 'no-img') {
      setState(() {
        _image = File(imagepicked!.path);
        isimage = true;
      });
    }
  }

  @override
  void initState() {
    namecontroller.text = student.name;
    agecontroller.text = student.age;
    stdcontroller.text = student.std;
    phonecontroller.text = student.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Enter details',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 40,
              ),
              InputfieldWidget(
                  inputcontroller: namecontroller,
                  label: 'name',
                  type: TextInputType.name),
              InputfieldWidget(
                  inputcontroller: agecontroller,
                  label: 'Age',
                  type: TextInputType.number),
              InputfieldWidget(
                  inputcontroller: stdcontroller,
                  label: 'Class',
                  type: TextInputType.text),
              InputfieldWidget(
                  inputcontroller: phonecontroller,
                  label: 'Phone',
                  type: TextInputType.number),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                        ),
                        const Icon(Icons.add_a_photo),
                        const Text('change photo'),
                        const SizedBox(
                          width: 5,
                        ),
                        Visibility(
                            child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                          child: ClipOval(
                              child: SizedBox.fromSize(
                            size: const Size.fromRadius(60),
                            child: (_image != null)
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/images/person.jpg'),
                          )),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Column(
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      child: const Text('update details'),
                      onPressed: () {
                        StudentModel stu = StudentModel(
                            imgpath: _image?.path ?? student.imgpath,
                            name: namecontroller.text,
                            age: agecontroller.text,
                            std: stdcontroller.text,
                            phone: phonecontroller.text,
                            id: student.id);
                        updateSstudent(stu);
                        getalldata();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
