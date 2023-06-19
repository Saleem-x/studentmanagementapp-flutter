import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_management/bloc/editscreen/editscreen_state.dart';

part 'editscreen_event.dart';

class EditscreenBloc extends Bloc<EditscreenEvent, EditScreenState> {
  EditscreenBloc() : super(EditScreenInitial('img')) {
    on<ImageEditEvent>((event, emit) {
      emit(EditScreenState(event.imgpath));
    });
  }
}
