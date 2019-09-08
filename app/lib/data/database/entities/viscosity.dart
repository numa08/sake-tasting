import 'package:equatable/equatable.dart';

abstract class Viscosity extends Equatable {
  const Viscosity([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
