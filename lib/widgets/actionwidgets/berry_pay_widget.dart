

// berry_pay_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../providers/berry_pay_provider.dart';
import '../../viewmodels/widgetsviewmodels/price_viewmodel.dart';
import '../profile_widget.dart/balance_widget.dart';

class UserProfile {
  final String solanaAddress;
  final String username;

  UserProfile({required this.solanaAddress, required this.username});
}

class BerryPayment extends ConsumerWidget {
  final UserProfile receiverProfile;
  final UserProfile senderProfile;
  final double price;
  const BerryPayment({super.key, 
    required this.receiverProfile,
    required this.senderProfile,
    required this.price,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(paymentViewModelProvider);
    final priceViewModel = ref.watch(priceViewModelProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // RecipientQr and UserName
          Column(
            children: <Widget>[
              QrImageView(
                data: receiverProfile.solanaAddress,
                version: QrVersions.auto,
                size: 200.0,
              ),
              Text(receiverProfile.username),
            ],
          ),
          // UpArrow and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.arrow_upward),
              const SizedBox(width: 10),
              Text('Price: ${priceViewModel}berry'),// TODO: #39 Create and place unit notations
            ],
          ),
          // SenderQr and UserName
          Column(
            children: <Widget>[
              QrImageView(
                data: senderProfile.solanaAddress,
                version: QrVersions.auto,
                size: 200.0,
              ),
              Text(senderProfile.username),
            ],
          ),
          // PayButton
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, 
              backgroundColor: Colors.green, 
            ),
            onPressed: () => viewModel.sendPayment(),
            child: const Text('Pay', style: TextStyle(fontFamily: 'Roboto')),
          ),
          // Show current balance
          const BalanceWidget(),
        ],
      ),
    );
  }
}