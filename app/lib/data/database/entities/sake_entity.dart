import 'package:equatable/equatable.dart';

abstract class SakeEntity extends Equatable {
  const SakeEntity([List props = const <dynamic>[]]) : super(props);
  String get id;
  String get name;
  String get breweriesID;
  String get visualSoundness;
  String get hueOther;
  String get viscosityOther;
  String get flavorSoundness;
  String get flavorStrengthOther;
  String get flavorExample;
  String get mainFlavor;
  String get flavorComplexityOther;
  String get tasteSoundness;
  String get attackOther;
  String get texture;
  String get tasteExample;
  String get sweetnessOther;
  String get aromaOther;
  String get aromaExample;
  String get reverberationOther;
  String get reverberationElement;
  String get aromaComplexityOther;
  String get individuality;
  String get notice;
  String get typeNotice;
  int get createdAtUTC;
  int get updatedAtUTC;
  Map<String, dynamic> toJson();
}
