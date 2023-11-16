

// pay_widget.dart
import 'dart:io';
import 'package:bennu_app/widgets/actionwidgets/berry_pay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/pay_provider.dart';
import '../../viewmodels/widgetsviewmodels/price_viewmodel.dart';


class PayWidget extends ConsumerWidget {
  final UserProfile receiverProfile;
  final UserProfile senderProfile;
  final double price;

  const PayWidget({
    Key? key,
    required this.receiverProfile,
    required this.senderProfile,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBerry = ref.watch(priceViewModelProvider);
    final selectedIndex = isBerry ? 1 : 0;
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'Apple/Google Pay'),
              Tab(text: 'Berry'),
            ],
            onTap: (index) => ref.read(payViewModelProvider.notifier).selectTab(index),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                _appleGooglePayTab(context,ref),
                _berryPaymentTab(context,ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _appleGooglePayTab(BuildContext context, WidgetRef ref) {
    if (Platform.isIOS) {
      _processApplePayPayment(context);
    } else if (Platform.isAndroid) {
       _processGooglePayPayment(context);
    }
    // プラットフォームによらず表示されるUI
    return const Center(
      child: Text('Processing payment...'),
    );
  }
  void _processApplePayPayment(BuildContext context) {
    // Apple Pay の決済処理を実装
    // StripeのAPIキーとApple Payの設定を使用
  }

  void _processGooglePayPayment(BuildContext context) {
    // Google Pay の決済処理を実装
    // StripeのAPIキーとGoogle Payの設定を使用
  }

  // Berry Pay
  Widget _berryPaymentTab(BuildContext context, WidgetRef ref) {
    return BerryPayment(
      receiverProfile: receiverProfile,
      senderProfile: senderProfile,
      price: price,
    );
  }
}
