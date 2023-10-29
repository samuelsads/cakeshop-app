import 'package:bloc/bloc.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/entities/total_order.dart';
import 'package:cakeshopapp/domain/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc(this.orderRepository) : super(const OrderState()) {
    on<AllOrderEvent>(
      (event, emit) => emit(state.copyWith(
          order: event.order, status: event.status, total: event.total)),
    );
  }

  Future<Save> updateDelivered(String uuid) async {
    Save response;
    response = await orderRepository.updateOrderStatus(uuid);
    return response;
  }

  Future<Save> saveOrder(Map<String, dynamic> data, bool update) async {
    Save response;
    if (update) {
      response = await orderRepository.updateOrder(data);
    } else {
      response = await orderRepository.saveOrder(data);
    }

    if (response.success) {
      allOrders(0, 10, false);
    }
    return response;
  }

  Future<void> allOrders(int start, int limit, bool delivered) async {
    add(const AllOrderEvent(status: OrderStatus.loading));

    try {
      final data = await orderRepository.getAll(start, limit, delivered);
      final total = await orderRepository.getTotal(delivered);
      add(AllOrderEvent(
          order: data, status: OrderStatus.success, total: total));
    } catch (e) {
      add(const AllOrderEvent(status: OrderStatus.error));
    }
  }
}
