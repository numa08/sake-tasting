import 'package:flutter/material.dart';

class FutureSlider extends StatefulWidget {
  const FutureSlider({Key key, this.value, this.onChanged}) : super(key: key);
  final Future<double> value;
  final ValueChanged<double> onChanged;

  @override
  State<StatefulWidget> createState() => _FutureSliderState();
}

class _FutureSliderState extends State<FutureSlider> {
  double _value;

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = 0.5;
    });
    widget.value.then((v) {
      setState(() {
        if(v == null) {
          return;
        }
        _value = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Slider.adaptive(
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          widget.onChanged(value);
        },
        value: _value,
        min: 0,
        max: 1,
      );
}
