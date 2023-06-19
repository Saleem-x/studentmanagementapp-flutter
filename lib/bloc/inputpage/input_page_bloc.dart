import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/bloc/inputpage/input_page_event.dart';
import 'package:student_management/bloc/inputpage/input_page_state.dart';

class InputPageBloc extends Bloc<InputPageEvent, InputPageState> {
  InputPageBloc() : super(InputPageInitial('img')) {
    on<PickImageEvent>((event, emit) {
      emit(InputPageState(event.imagepath));
    });
  }
}
