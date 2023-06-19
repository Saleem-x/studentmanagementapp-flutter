import 'package:flutter/material.dart';

@immutable
abstract class InputPageEvent {}

class PickImageEvent extends InputPageEvent {
  final String imagepath;
  PickImageEvent({required this.imagepath});
}
