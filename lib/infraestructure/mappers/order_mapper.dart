import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/total_order.dart';
import 'package:cakeshopapp/domain/entities/user.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/orderdb_response.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/totalorderdo_response.dart';

class OrderMapper {
  static Order orderDbEntity(Datum order) => Order(
      description: order.description,
      price: order.price,
      orderDeliveryDate: order.orderDeliveryDate,
      discount: order.discount ?? 0.0,
      delivered: order.delivered,
      paid: order.paid,
      clientId: Client(
          name: order.clientId.name,
          fatherSurname: order.clientId.fatherSurname,
          motherSurname: order.clientId.motherSurname ?? "",
          userId: order.clientId.id,
          createdAt: DateTime.now(),
          uid: ""),
      userId: User(
          name: order.userId.name,
          fatherSurname: order.userId.fatherSurname,
          motherSurname: order.userId.motherSurname ?? "",
          email: "",
          role: 1,
          uid: order.userId.id),
      uid: order.uid,
      createdAt: order.createdAt,
      advancePayment: order.advancePayment,
      advancePaymentType: order.advancePaymentType,
      totalProduct: order.totalProduct);

  static TotalOrder totalOrderDbEntity(TotalOrderDbResponse order) =>
      TotalOrder(
          success: order.success,
          today: order.today,
          tomorrow: order.tomorrow,
          total: order.total);
}
