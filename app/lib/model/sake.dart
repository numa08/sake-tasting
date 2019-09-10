import 'package:equatable/equatable.dart';

class SakeID extends Equatable {
  SakeID({this.value}) : super(<dynamic>[value]);

  final String value;
}

class Sake extends Equatable {
  Sake({this.id, this.name}) : super(<dynamic>[id]);
  final SakeID id;
  final String name;
}
