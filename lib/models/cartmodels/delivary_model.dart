// Model
enum DeliveryStatus { initial, shipped, delivered }

class DeliveryState {
  final DeliveryStatus status;

  DeliveryState({required this.status});

  DeliveryState copyWith({DeliveryStatus? status}) {
    return DeliveryState(
      status: status ?? this.status,
    );
  }

  static DeliveryState initial() => DeliveryState(status: DeliveryStatus.initial);
}
