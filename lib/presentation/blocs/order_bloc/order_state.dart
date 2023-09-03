part of 'order_bloc.dart';

enum OrderStatus {
  initial,
  loading,
  success,
  error,
  done,
}

class OrderState extends Equatable {
  const OrderState({this.order, this.status = OrderStatus.initial, this.total});

  final List<Order>? order;
  final OrderStatus status;
  final TotalOrder? total;

  OrderState copyWith(
          {List<Order>? order, OrderStatus? status, TotalOrder? total}) =>
      OrderState(
          order: order ?? this.order,
          status: status ?? this.status,
          total: total ?? this.total);

  @override
  List<Object?> get props => [order, status, total];

  @override
  String toString() {
    return 'Order: $order, status: $status, total: $total';
  }
}

extension OrderStateX on OrderState {
  bool get orderLoading => status == OrderStatus.loading;
  bool get orderInitial => status == OrderStatus.initial;
  bool get orderError => status == OrderStatus.error;
  bool get orderSuccess => status == OrderStatus.success;
}
