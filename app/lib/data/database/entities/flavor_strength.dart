import 'package:equatable/equatable.dart';

abstract class FlavorStrength extends Equatable {
  const FlavorStrength([List props = const <dynamic>[]]) : super(props);
  String get id;
  int get value;
  String get sakeID;
}
