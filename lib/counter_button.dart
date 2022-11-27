import 'package:flutter/material.dart';

class ButtonCounterCustom extends StatefulWidget {
  const ButtonCounterCustom(
      {super.key, required this.startCounter, required this.currentCounter});

  final int? startCounter;
  final ValueSetter<int> currentCounter;
  @override
  State<StatefulWidget> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<ButtonCounterCustom> {
  int _currentCounter = 0;
  @override
  void initState() {
    super.initState();
    _currentCounter = widget.startCounter!;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_currentCounter > 1) {
                    _currentCounter--;
                    widget.currentCounter(_currentCounter);
                  }
                });
              },
              child: const Icon(Icons.remove)),
        ),
        Expanded(child: Text(_currentCounter.toString(), textAlign: TextAlign.center)),
        Expanded(
          child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentCounter++;
                  widget.currentCounter(_currentCounter);
                });
              },
              child: const Icon(Icons.add)),
        )
      ],
    );
  }
}
