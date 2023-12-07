import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu/viewmodels/postwidgetviewmodels/price_edit_viewmodel.dart';

class PriceEditWidget extends ConsumerWidget {
  const PriceEditWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(priceEditViewModelProvider);
    final viewModel = ref.read(priceEditViewModelProvider.notifier);

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: '価格'),
          keyboardType: TextInputType.number,
          onChanged: (value) => viewModel.setPrice(num.tryParse(value) ?? 0),
        ),
        SwitchListTile(
          title: Text('通貨: ${product.isPriceInBerry ? "Berry" : "円"}'),
          value: product.isPriceInBerry,
          onChanged: (_) => viewModel.toggleCurrency(),
        ),
        // 他のUIコンポーネント...
      ],
    );
  }
}
