import 'package:equatable/equatable.dart';

abstract class BreweryEntity extends Equatable {
  const BreweryEntity([List props = const <dynamic>[]]) : super(props);
  String get id;
  String get name;
  Map<String, dynamic> toJson();
}
