import 'package:equatable/equatable.dart';

abstract class Image extends Equatable {
  const Image([List props = const <dynamic>[]]) : super(props);
  String get id;
  String get url;
  String get sakeID;
}
