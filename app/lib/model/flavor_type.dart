abstract class FlavorType {
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
  String get name;
}

class _Aromatic implements FlavorType {
  @override
  String get name => 'aromatic';
}

class _Refreshing implements FlavorType {
  @override
  String get name => 'refreshing';
}

class _Aged implements FlavorType {
  @override
  String get name => 'aged';
}

class _Rich implements FlavorType {
  @override
  String get name => 'rich';
}

class _Sparkling implements FlavorType {
  @override
  String get name => 'sparkling';
}
