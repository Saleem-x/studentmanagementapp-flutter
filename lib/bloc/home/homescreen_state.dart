import 'package:student_management/db/models/db_models.dart';

class HomeScreenState {
  final List<StudentModel> studentlist;
  HomeScreenState({required this.studentlist});
}

class HomeScreenInitial extends HomeScreenState {
  HomeScreenInitial({required super.studentlist});
}
