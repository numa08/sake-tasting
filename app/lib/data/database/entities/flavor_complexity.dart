import 'package:equatable/equatable.dart';

abstract class FlavorComplexity extends Equatable {
  const FlavorComplexity([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
