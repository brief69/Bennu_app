import 'package:flutter/material.dart';


class SimpleCountWidget extends StatefulWidget {
  final int initialCount;
  final ValueChanged<int> onCountChanged;

  const SimpleCountWidget({super.key, required this.initialCount, required this.onCountChanged});

  @override
  SimpleCountWidgetState createState() => SimpleCountWidgetState();
}

class SimpleCountWidgetState extends State<SimpleCountWidget> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  void _incrementCount() {
    setState(() {
      _count++;
      widget.onCountChanged(_count);
    });
  }

  void _decrementCount() {
    if (_count > 0) {
      setState(() {
        _count--;
        widget.onCountChanged(_count);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrementCount,
        ),
        Text('$_count'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _incrementCount,
        ),
      ],
    );
  }
}