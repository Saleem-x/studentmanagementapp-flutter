import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/bloc/editscreen/editscreen_bloc.dart';
import 'package:student_management/bloc/editscreen/editscreen_state.dart';
import 'package:student_management/db/models/db_models.dart';
import 'package:student_management/widgets/inputfield.dart';
import '../db/functions/db_functions.dart';

// ignore: must_be_immutable
class InputBottomsheet extends StatelessWidget {
  StudentModel student;
  final int index;
  InputBottomsheet({super.key, required this.student, required this.index});

  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController stdcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  bool isimage = false;
  File? _image;

  //? picking image for update
  Future<void> pickImage(BuildContext context) async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // ignore: unrelated_type_equality_checks
    if (_image != 'no-img') {
      _image = File(imagepicked!.path);
      isimage = true;
      // ignore: use_build_context_synchronously
      BlocProvider.of<EditscreenBloc>(context)
          .add(ImageEditEvent(imgpath: _image!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    namecontroller.text = student.name;
    agecontroller.text = student.age;
    stdcontroller.text = student.std;
    phonecontroller.text = student.phone;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    'Enter details',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              //! text field widget
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
                      pickImage(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            //! buildidng state
                            child: BlocBuilder<EditscreenBloc, EditScreenState>(
                          builder: (context, state) {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: ClipOval(
                                  child: SizedBox.fromSize(
                                size: const Size.fromRadius(60),
                                child:
                                    (_image != null && _image!.path != 'no-img')
                                        ? Image.file(
                                            File(state.imgpath!),
                                            fit: BoxFit.cover,
                                          )
                                        : student.imgpath != 'no-img'
                                            ? Image.file(
                                                File(student.imgpath!),
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/person.jpg',
                                                fit: BoxFit.cover,
                                              ),
                              )),
                            );
                          },
                        ))
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      child: const Text(
                        'update details',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        StudentModel stu = StudentModel(
                            imgpath: _image?.path ?? student.imgpath,
                            name: namecontroller.text,
                            age: agecontroller.text,
                            std: stdcontroller.text,
                            phone: phonecontroller.text,
                            id: student.id);
                        updateSstudent(stu, context, index);
                        getalldata();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
