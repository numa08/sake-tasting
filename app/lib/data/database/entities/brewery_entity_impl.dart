import 'package:json_annotation/json_annotation.dart';

import 'brewery_entity.dart';

part 'brewery_entity_impl.g.dart';

@JsonSerializable()
class BreweryEntityImpl extends BreweryEntity {
  BreweryEntityImpl({this.id, this.name}) : super(<dynamic>[id, name]);

  @override
  final String id;
  @override
  final String name;

  @override
  Map<String, dynamic> toJson() {
    return _$BreweryEntityImplToJson(this);
  }
}
