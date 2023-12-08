import 'package:bennu/models/cartmodels/delivary_model.dart';
import 'package:bennu/services/hapi_api_service.dart';
import 'package:bennu/viewmodels/widgetsviewmodels/delivary_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providerの更新
final deliveryViewModelProvider = StateNotifierProvider<DeliveryViewModel, DeliveryState>(
  (ref) => DeliveryViewModel(HapiApiService(), FirestoreService()),
);
