import 'package:equatable/equatable.dart';

abstract class Attack extends Equatable {
  const Attack([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
