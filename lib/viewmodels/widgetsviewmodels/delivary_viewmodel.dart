// ViewModelの更新
import 'package:bennu/models/cartmodels/delivary_model.dart';
import 'package:bennu/services/hapi_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryViewModel extends StateNotifier<DeliveryState> {
  final HapiApiService _hapiApiService;
  final FirestoreService _firestoreService;

  DeliveryViewModel(this._hapiApiService, this._firestoreService) : super(DeliveryState.initial()) {
    _init();
  }

  Future<void> _init() async {
    // Hapi APIから初期状態を取得
    updateDeliveryStatus(await _hapiApiService.fetchDeliveryStatus());

    // Firestoreの変更をリッスン
    _firestoreService.getDeliveryStatusStream().listen((status) {
      updateDeliveryStatus(status);
    });
  }

  void updateDeliveryStatus(DeliveryStatus status) {
    state = state.copyWith(status: status);
  }
}
