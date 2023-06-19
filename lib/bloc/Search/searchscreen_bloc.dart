import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/models/db_models.dart';
part 'searchscreen_event.dart';
part 'searchscreen_state.dart';

class SearchscreenBloc extends Bloc<SearchscreenEvent, SearchscreenState> {
  SearchscreenBloc()
      : super(SearchscreenInitial(studentlist: studentlistnotifier)) {
    on<OnSearch>((event, emit) {
      emit(SearchscreenState(
          studentlist: event.studentlist
              .where((element) => element.name
                  .toLowerCase()
                  .contains(event.value.toLowerCase()))
              .toList()));
    });
  }
}
