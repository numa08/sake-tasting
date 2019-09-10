import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sake.g.dart';

abstract class Sake extends Equatable {
  const Sake([List props = const <dynamic>[]]) : super(props);
  factory Sake.fromJSON(Map<String, dynamic> json) =>
      _$_SQLiteSakeFromJson(json);
  String get sakeID;
  String get name;
  String get breweryID;
}

@JsonSerializable()
class _SQLiteSake extends Sake {
  _SQLiteSake(this.breweryID, this.sakeID, this.name)
      : super(<dynamic>[breweryID, sakeID, name]);

  @override
  @JsonKey(name: 'brewery_id')
  final String breweryID;

  @override
  @JsonKey(name: 'id')
  final String sakeID;

  @override
  final String name;
}
