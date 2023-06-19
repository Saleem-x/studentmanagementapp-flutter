part of 'searchscreen_bloc.dart';

class SearchscreenState {
  final List<StudentModel> studentlist;
  SearchscreenState({required this.studentlist});
}

class SearchscreenInitial extends SearchscreenState {
  SearchscreenInitial({required super.studentlist});
}
