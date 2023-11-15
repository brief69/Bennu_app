

// balance_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/balance_provider.dart';

class BalanceWidget extends ConsumerWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceProvider);
    final showBalance = ref.watch(showBalanceProvider);
    final currencyDisplay = ref.watch(currencyDisplayProvider);

    return Column(
      children: <Widget>[
        // 金額表示
        Visibility(
          visible: showBalance,
          child: GestureDetector(
            onTap: () => ref.read(currencyDisplayProvider.state).state = !currencyDisplay,
            child: Text(
              currencyDisplay ? '${balance.balanceInSolana} b' : '¥${balance.balanceInYen}',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        IconButton(
          icon: Icon(showBalance ? Icons.visibility : Icons.visibility_off),
          onPressed: () => ref.read(showBalanceProvider.state).state = !showBalance,
        ),
      ],
    );
  }
}