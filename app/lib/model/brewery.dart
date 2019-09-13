import 'package:equatable/equatable.dart';

class BreweryID extends Equatable {
  BreweryID({this.value}) : super(<dynamic>[value]);

  final String value;
}

class Brewery extends Equatable {
  Brewery({this.id, this.name}) : super(<dynamic>[id]);
  final BreweryID id;
  final String name;
  Brewery copyTo({String name}) => Brewery(id: id, name: name ?? this.name);
}
