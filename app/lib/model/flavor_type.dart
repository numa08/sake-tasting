import 'package:equatable/equatable.dart';

abstract class FlavorType extends Equatable {
    const FlavorType([List props = const <dynamic>[]]) : super(props);

  factory FlavorType.fromName(String name) {
    switch (name) {
      case 'aromatic':
        return _Aromatic();
        break;
      case 'refreshing':
        return _Refreshing();
        break;
      case 'aged':
        return _Aged();
        break;
      case 'rich':
        return _Rich();
        break;
      case 'sparkling':
        return _Sparkling();
        break;
      default:
        throw ArgumentError('name が不正です :$name');
        break;
    }
  }

  factory FlavorType.aromatic() => _Aromatic();
  factory FlavorType.refreshing() => _Refreshing();
  factory FlavorType.aged() => _Aged();
  factory FlavorType.rich() => _Rich();
  factory FlavorType.sparkling() => _Sparkling();

  String get name;
}

class _Aromatic extends FlavorType {
  @override
  String get name => 'aromatic';
}

class _Refreshing extends FlavorType {
  @override
  String get name => 'refreshing';
}

class _Aged extends FlavorType {
  @override
  String get name => 'aged';
}

class _Rich extends FlavorType {
  @override
  String get name => 'rich';
}

class _Sparkling extends FlavorType {
  @override
  String get name => 'sparkling';
}
