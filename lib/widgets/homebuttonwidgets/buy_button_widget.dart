

// buy_button_widget.dart
import 'dart:async';
import 'package:bennu_app/widgets/actionwidgets/pay_widget.dart';
import 'package:flutter/material.dart';

import '../actionwidgets/berry_pay_widget.dart';



class BuyButton extends StatefulWidget {
  final double defaultWidth;
  final String price;
  final bool isExtendedByDefault;
  final UserProfile receiverProfile;
  final UserProfile senderProfile;
  
  const BuyButton({
  super.key, 
  this.defaultWidth = 150.0, 
  required this.price, 
  this.isExtendedByDefault = false,
  required this.receiverProfile, 
  required this.senderProfile,
});

  @override
  BuyButtonState createState() => BuyButtonState();
}

class BuyButtonState extends State<BuyButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _timer;
  late double width;
  bool _isExtended = false;

  @override
  void initState() {
    super.initState();

    _isExtended = widget.isExtendedByDefault;
      width = _isExtended ? 250.0 : widget.defaultWidth;

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchPayment();
        if (_isExtended) {
          _resetWidth();
        } else {
          _extendButton();
        }
      },
      onLongPress: _extendButton,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 96),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.blue[200]!.withOpacity(0.6 * _animationController.value),
            width: 2.0,
          ),
        ),
        child: Center(
          child: _isExtended ? Text(widget.price, style: const TextStyle(color: Colors.white)) : const Text("Buy", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  void _extendButton() {
    setState(() {
      width = 250.0;
      _isExtended = true;
    });
    _timer = Timer(const Duration(seconds: 9), _resetWidth);
  }

  void _resetWidth() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      width = widget.defaultWidth;
      _isExtended = false;
    });
  }

  void _launchPayment() {
    showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return PayWidget(
        price: double.parse(widget.price),
        receiverProfile: widget.receiverProfile,
        senderProfile: widget.senderProfile,
      );
    },
  );
}

  @override
  void dispose() {
    _animationController.dispose();
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

}