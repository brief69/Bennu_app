

// stock_widget.dart
import 'package:flutter/material.dart';

class CountWidget extends StatefulWidget {
  final int currentCount;
  final int maxCount;
  final ValueChanged<int> onCountChanged;

  const CountWidget({
    Key? key,
    required this.currentCount,
    required this.maxCount,
    required this.onCountChanged,
  }) : super(key: key);

  @override
  CountWidgetState createState() => CountWidgetState();
}

class CountWidgetState extends State<CountWidget> {
  late int currentCount;

  @override
  void initState() {
    super.initState();
    currentCount = widget.currentCount;
  }

  void _incrementCount() {
    if (currentCount < widget.maxCount) {
      setState(() {
        currentCount++;
        widget.onCountChanged(currentCount);
      });
    }
  }

  void _decrementCount() {
    if (currentCount > 0) {
      setState(() {
        currentCount--;
        widget.onCountChanged(currentCount);
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
        Text('$currentCount'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _incrementCount,
        ),
      ],
    );
  }
}
