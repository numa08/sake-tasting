import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brewery.g.dart';

abstract class Brewery extends Equatable {
  const Brewery([List props = const <dynamic>[]]) : super(props);
  factory Brewery.fromJSON(Map<String, dynamic> json) =>
      _$_SQLiteBreweryFromJson(json);
  String get breweryID;
  String get name;
}

@JsonSerializable()
class _SQLiteBrewery extends Brewery {
  _SQLiteBrewery(this.breweryID, this.name) : super(<dynamic>[breweryID, name]);

  @override
  @JsonKey(name: 'id')
  final String breweryID;

  @override
  final String name;
}
