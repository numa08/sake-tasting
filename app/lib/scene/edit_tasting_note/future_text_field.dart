import 'package:flutter/material.dart';

class FutureTextField extends StatelessWidget {
  const FutureTextField({Key key, this.future, this.label, this.onChanged})
      : super(key: key);
  final Future<String> future;
  final String label;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
        future: future,
        builder: (context, snapshot) => TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: label,
          ),
          onChanged: onChanged,
          controller: TextEditingController.fromValue(snapshot.hasData
              ? TextEditingValue(
                  text: snapshot.data,
                  selection:
                      TextSelection.collapsed(offset: snapshot.data.length))
              : TextEditingValue.empty),
        ),
      );
}
