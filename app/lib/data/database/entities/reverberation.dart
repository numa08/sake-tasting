import 'package:equatable/equatable.dart';

abstract class Reverberation extends Equatable {
  const Reverberation([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
