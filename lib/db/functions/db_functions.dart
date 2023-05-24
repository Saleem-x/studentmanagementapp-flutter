import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/db/models/db_models.dart';

ValueNotifier<List<StudentModel>> studentlistnotifier = ValueNotifier([]);
List<StudentModel> studenList = [];

Future<void> addStudent(StudentModel value) async {
  final _db = await Hive.openBox<StudentModel>('student.db');
  await _db.put(value.id, value);
}

Future<void> getalldata() async {
  final _db = await Hive.openBox<StudentModel>('student.db');
  studentlistnotifier.value.clear();
  studentlistnotifier.value.addAll(_db.values);
  studenList.addAll(_db.values);
  studentlistnotifier.notifyListeners();
}

Future<void> deletestudent(StudentModel value) async {
  final _db = await Hive.openBox<StudentModel>('student.db');
  await _db.delete(value.id);
  getalldata();
}

Future<void> updateSstudent(StudentModel value) async {
  final db = await Hive.openBox<StudentModel>('student.db');
  final student = db.get(value.id);
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
  await db.put(value.id, student!);
  studentlistnotifier.notifyListeners();
  getalldata();
}
