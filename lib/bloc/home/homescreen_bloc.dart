import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/bloc/home/homescreen_event.dart';
import 'package:student_management/bloc/home/homescreen_state.dart';
import 'package:student_management/db/functions/db_functions.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc()
      : super(HomeScreenInitial(studentlist: studentlistnotifier)) {
    on<AddStudent>((event, emit) {
      studentlistnotifier.add(event.value);
      return emit(HomeScreenState(studentlist: studentlistnotifier));
    });
    on<DeleteStudent>((event, emit) {
      studentlistnotifier.removeAt(event.index);
      return emit(HomeScreenState(studentlist: studentlistnotifier));
    });
    on<EditStudent>((event, emit) {
      studentlistnotifier.removeAt(event.index);
      studentlistnotifier.insert(event.index, event.value);
      return emit(HomeScreenState(studentlist: studentlistnotifier));
    });
  }
}
