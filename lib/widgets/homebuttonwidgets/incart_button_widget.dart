

// incart_button_widget.dart
import 'package:bennu/models/homewidgetmodels/media_model.dart';
import 'package:bennu/viewmodels/home_viewmodel.dart';
import 'package:bennu/viewmodels/media_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../actionwidgets/counter_widget.dart';

class InCartWidget extends StatefulWidget {
  final String productId;
  final int stock;
  final int initialInCart;

  const InCartWidget({
    Key? key,
    required this.productId,
    required this.stock,
    required this.initialInCart, required String postId,
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

  void _updateInCart(int newInCart, WidgetRef ref) {
    setState(() {
      inCart = newInCart;
    });
    // カートの数量を更新
    ref.read(cartProvider.notifier).updateQuantity(widget.productId, newInCart);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
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
                ? CountWidget(
                    currentCount: inCart,
                    maxCount: widget.stock,
                    onCountChanged: (newCount) => _updateInCart(newCount, ref), mediaItem: MediaViewModel(mediaViewModelProvider as MediaModel),
                  )
                : Center(
                    child: Text(
                      'In Cart ($inCart)',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

