import 'package:equatable/equatable.dart';

abstract class SakeType extends Equatable {
  const SakeType([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
