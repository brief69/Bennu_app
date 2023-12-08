import 'package:bennu/models/cartmodels/delivary_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Hapi APIサービス
class HapiApiService {
  // Hapi APIから配送状況を取得するメソッド（仮想的な実装）
  Future<DeliveryStatus> fetchDeliveryStatus() async {
    // ここにAPI通信のロジックを実装
    // 例: http.get('https://api.hapi.com/delivery/status');
    // この例では仮のデータを返します
    await Future.delayed(const Duration(seconds: 2));
    return DeliveryStatus.delivered; // 仮のレスポンス
  }
}

// Firestoreサービス
class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DeliveryStatus> getDeliveryStatusStream() {
    return firestore.collection('deliveries').doc('deliveryId').snapshots().map((snapshot) {
      // FirestoreドキュメントからDeliveryStatusを取得して返す
      // ドキュメントの構造に合わせて調整
      var status = snapshot.data()?['status'] ?? 'initial';
      return _mapStatusStringToEnum(status);
    });
  }

  DeliveryStatus _mapStatusStringToEnum(String status) {
    switch (status) {
      case 'shipped':
        return DeliveryStatus.shipped;
      case 'delivered':
        return DeliveryStatus.delivered;
      default:
        return DeliveryStatus.initial;
    }
  }
}
