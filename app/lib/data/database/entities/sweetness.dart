import 'package:equatable/equatable.dart';

abstract class Sweetness extends Equatable {
  const Sweetness([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
