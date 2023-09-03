part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AllOrderEvent extends OrderEvent {
  final List<Order>? order;
  final OrderStatus status;
  final TotalOrder? total;

  const AllOrderEvent(
      {this.order, this.status = OrderStatus.initial, this.total});
}
