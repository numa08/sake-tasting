import 'package:app/model/model.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends InheritedWidget {
  const ServiceProvider({this.editTastingNoteModel, Widget child})
      : super(child: child);
  final EditTastingNoteModel editTastingNoteModel;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static ServiceProvider of(BuildContext context) => context
      .ancestorInheritedElementForWidgetOfExactType(ServiceProvider)
      .widget as ServiceProvider;
}
