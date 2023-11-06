

// in_cart_widget.dart
import 'package:flutter/material.dart';
import 'stock_widget.dart'; // StockWidgetをインポート

class InCartWidget extends StatefulWidget {
  final int stock;
  final int initialInCart;

  const InCartWidget({
    Key? key,
    required this.stock,
    required this.initialInCart,
  }) : super(key: key);

  @override
  InCartWidgetState createState() => InCartWidgetState();
}

class InCartWidgetState extends State<InCartWidget> {
  bool isExpanded = false;
  late int inCart;

  @override
  void initState() {
    super.initState();
    inCart = widget.initialInCart;
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _updateInCart(int newInCart) {
    setState(() {
      inCart = newInCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpansion,
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        curve: Curves.fastOutSlowIn,
        width: isExpanded ? 200 : 100,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(isExpanded ? 1 : 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: isExpanded
            ? StockWidget(
                currentStock: inCart,
                maxStock: widget.stock,
                onStockChanged: _updateInCart,
              )
            : Center(
                child: Text(
                  'In Cart ($inCart)',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
