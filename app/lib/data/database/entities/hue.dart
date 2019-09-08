import 'package:equatable/equatable.dart';

abstract class Hue extends Equatable {
  const Hue([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
