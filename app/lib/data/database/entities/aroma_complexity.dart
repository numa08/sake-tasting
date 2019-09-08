import 'package:equatable/equatable.dart';

abstract class AromaComplexity extends Equatable {
  const AromaComplexity([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
