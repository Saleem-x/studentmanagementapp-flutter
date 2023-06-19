import 'package:student_management/db/models/db_models.dart';

abstract class HomeScreenEvent {}

class AddStudent extends HomeScreenEvent {
  final StudentModel value;
  AddStudent({required this.value});
}

class EditStudent extends HomeScreenEvent {
  final int index;
  final StudentModel value;
  EditStudent({required this.index, required this.value});
}

class DeleteStudent extends HomeScreenEvent {
  final int index;
  DeleteStudent({required this.index});
}
