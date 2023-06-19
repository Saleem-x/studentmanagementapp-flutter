part of 'searchscreen_bloc.dart';

@immutable
abstract class SearchscreenEvent {}

class OnSearch extends SearchscreenEvent {
  final List<StudentModel> studentlist;
  final String value;
  OnSearch({required this.studentlist, required this.value});
}
