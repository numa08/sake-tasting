import 'package:app/data/entities/brewery.dart';

enum Hue { transparent }
enum Viscosity { row }
enum Strength { row }
enum Complexity { simple }
enum Attack { weak }
enum Sweetness { sweet }
enum Length { short }
enum Type { aromatic }

abstract class Sake {
  String get id;
  String get name;
  List<String> get image;
  Brewery get brewery;
  String get visualSoundness;
  List<Hue> get hue;
  String get hueOther;
  List<Viscosity> get viscosity;
  String get viscosityOther;
  String get flavorSoundness;
  List<Strength> get flavorStrength;
  String get flavorStrengthOther;
  String get flavorExample;
  String get mainFlavor;
  List<Complexity> get flavorComplexity;
  String get flavorComplexityOther;
  String get tasteSoundness;
  List<Attack> get attack;
  String get attackOther;
  String get texture;
  String get tasteExample;
  List<Sweetness> get sweetness;
  String get sweetnessOther;
  List<Strength> get aroma;
  String get aromaOther;
  String get aromaExample;
  List<Length> get reverberation;
  String get reverberationOther;
  String get reverberationElement;
  List<Complexity> get aromaComplexity;
  String get aromaComplexityOther;
  String get individuality;
  String get notice;
  List<Type> get type;
  String get typeNotice;
  DateTime get createdAt;
  DateTime get updatedAt;
}
