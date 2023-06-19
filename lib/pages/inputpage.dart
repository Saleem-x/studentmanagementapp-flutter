import 'dart:developer';
 import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/bloc/inputpage/input_page_bloc.dart';
import 'package:student_management/bloc/inputpage/input_page_event.dart';
import 'package:student_management/bloc/inputpage/input_page_state.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/models/db_models.dart';
import 'package:student_management/widgets/inputfield.dart';

// ignore: must_be_immutable
class InputPage extends StatelessWidget {
  InputPage({super.key});

  String _image = 'img';

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _stdController = TextEditingController();
  final _phoneController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Enter details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(context),
                    //! building
                    child: BlocBuilder<InputPageBloc, InputPageState>(
                      builder: (context, state) {
                        log('hello');
                        return CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 60,
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(60),
                              child: (_image == 'img')
                                  ? Image.asset('assets/images/person.jpg')
                                  : Image.file(
                                      File(state.imagepath!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        );
                      },
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
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                StudentModel student = StudentModel(
                                    name: _nameController.text,
                                    age: _ageController.text,
                                    std: _stdController.text,
                                    phone: _phoneController.text,
                                    id: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    imgpath:
                                        _image == 'img' ? 'no-img' : _image);
                                addStudent(student, context);
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

//? image picking function ->

  Future<void> pickImage(BuildContext context) async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      _image = imagePicked.path;
      //! -> read the updated event and transfer it to the bloc to change state
      // ignore: use_build_context_synchronously
      BlocProvider.of<InputPageBloc>(context)
          .add(PickImageEvent(imagepath: imagePicked.path));
      log(_image);
    }
  }
}
