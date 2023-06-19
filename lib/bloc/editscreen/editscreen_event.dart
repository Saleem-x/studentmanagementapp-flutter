part of 'editscreen_bloc.dart';

@immutable
abstract class EditscreenEvent {}

class ImageEditEvent extends EditscreenEvent {
  final String imgpath;
  ImageEditEvent({required this.imgpath});
}
