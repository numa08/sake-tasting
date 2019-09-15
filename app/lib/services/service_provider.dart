import 'package:app/model/model.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends InheritedWidget {
  const ServiceProvider(
      {@required this.tastingNoteModel,
      @required this.editTastingNoteModel,
      Widget child})
      : super(child: child);
  final EditTastingNoteModel editTastingNoteModel;
  final TastingNoteModel tastingNoteModel;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static ServiceProvider of(BuildContext context) => context
      .ancestorInheritedElementForWidgetOfExactType(ServiceProvider)
      .widget as ServiceProvider;
}
