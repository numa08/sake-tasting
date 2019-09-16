import 'dart:io';

import 'package:equatable/equatable.dart';

class TastingNoteImageID extends Equatable {
  TastingNoteImageID({this.value}) : super(<dynamic>[value]);
  final String value;
}

class TastingNoteImage extends Equatable {
  TastingNoteImage({this.id, this.image}) : super(<dynamic>[id, image]);
  final TastingNoteImageID id;

  final File image;
}
