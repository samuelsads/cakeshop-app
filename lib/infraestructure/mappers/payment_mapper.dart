import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/entities/user.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/savedb_response.dart';
import 'package:cakeshopapp/infraestructure/models/paymentdb/paymentdb_response.dart'
    as P;

class PaymentMapper {
  static Payment payment(P.Datum s) => Payment(
      payment: s.payment,
      paymentType: s.paymentType,
      createdAt: s.createdAt,
      updateAt: s.updatedAt,
      user: User(
          name: s.userId.name,
          fatherSurname: s.userId.fatherSurname,
          motherSurname: s.userId?.motherSurname ?? "",
          email: s.userId.email,
          role: s.userId.role,
          uid: s.userId.id),
      order: Order(
          description: s.orderId.description,
          price: double.parse(s.orderId.price.toString()),
          orderDeliveryDate: s.orderId.orderDeliveryDate,
          discount: double.parse(s.orderId.discount.toString()),
          additionalThings: s.orderId.additionalThings,
          delivered: s.orderId.delivered,
          paid: s.orderId.paid,
          uid: s.orderId.id,
          createdAt: s.orderId.createdAt,
          advancePayment: s.orderId.advancePayment.toDouble(),
          advancePaymentType: s.orderId.advancePaymentType,
          totalProduct: s.orderId.totalProducts));

  static Save saveDbEntity(SavedbResponse s) =>
      Save(success: s.success, msg: s.msg, id: s.id ?? "");
}
