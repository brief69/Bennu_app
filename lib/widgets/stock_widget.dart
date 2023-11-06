

// stock_widget.dart
import 'package:flutter/material.dart';

class StockWidget extends StatefulWidget {
  final int currentStock;
  final int maxStock;
  final ValueChanged<int> onStockChanged;

  const StockWidget({
    Key? key,
    required this.currentStock,
    required this.maxStock,
    required this.onStockChanged,
  }) : super(key: key);

  @override
  StockWidgetState createState() => StockWidgetState();
}

class StockWidgetState extends State<StockWidget> {
  late int currentStock;

  @override
  void initState() {
    super.initState();
    currentStock = widget.currentStock;
  }

  void _incrementStock() {
    if (currentStock < widget.maxStock) {
      setState(() {
        currentStock++;
        widget.onStockChanged(currentStock);
      });
    }
  }

  void _decrementStock() {
    if (currentStock > 0) {
      setState(() {
        currentStock--;
        widget.onStockChanged(currentStock);
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
          onPressed: _decrementStock,
        ),
        Text('$currentStock'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _incrementStock,
        ),
      ],
    );
  }
}
