import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/bloc/home/homescreen_bloc.dart';
import 'package:student_management/bloc/home/homescreen_event.dart';
import 'package:student_management/db/models/db_models.dart';

List<StudentModel> studentlistnotifier = [];
List<StudentModel> studenList = [];

Future<void> addStudent(StudentModel value, BuildContext context) async {
  final db = await Hive.openBox<StudentModel>('student.db');
  await db.add(value);
  //! calling add student event
  // ignore: use_build_context_synchronously
  BlocProvider.of<HomeScreenBloc>(context).add(AddStudent(value: value));
}

getalldata() async {
  final db = Hive.box<StudentModel>('student.db');
  studentlistnotifier.clear();
  studentlistnotifier.addAll(db.values);
}

deletestudent(BuildContext context, int indx) async {
  final studentDB = Hive.box<StudentModel>('student.db');
  // ignore: use_build_context_synchronously
  //! calling delete student event
  BlocProvider.of<HomeScreenBloc>(context).add(DeleteStudent(index: indx));
  await studentDB.deleteAt(indx);
  getalldata();
}

updateSstudent(StudentModel value, BuildContext context, int idx) async {
  final db = Hive.box<StudentModel>('student.db');
  final student = db.getAt(idx);
  if (student?.name != value.name) {
    student?.name = value.name;
  }
  if (student?.age != value.age) {
    student?.age = value.age;
  }
  if (student?.std != value.std) {
    student?.std = value.std;
  }
  if (student?.phone != value.phone) {
    student?.phone = value.phone;
  }
  if (student?.imgpath != value.imgpath) {
    student?.imgpath = value.imgpath;
  }
  await db.putAt(idx, student!);
  //! calling update student event
  // ignore: use_build_context_synchronously
  BlocProvider.of<HomeScreenBloc>(context)
      .add(EditStudent(index: idx, value: student));
  getalldata();
}
