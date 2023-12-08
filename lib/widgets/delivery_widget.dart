import 'package:bennu/models/cartmodels/delivary_model.dart';
import 'package:bennu/providers/delivary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryWidget extends ConsumerWidget {
  const DeliveryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryState = ref.watch(deliveryViewModelProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNode(deliveryState.status == DeliveryStatus.shipped || deliveryState.status == DeliveryStatus.delivered),
        Expanded(child: Container(height: 2.0, color: Colors.grey)),
        _buildNode(deliveryState.status == DeliveryStatus.delivered),
      ],
    );
  }

  Widget _buildNode(bool isActive) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
    );
  }
}