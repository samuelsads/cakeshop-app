import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/cliente_details.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/infraestructure/models/clientdb/client_detailsdb_response.dart'
    as CD;
import 'package:cakeshopapp/infraestructure/models/clientdb/clientdb_search_response.dart';

class ClientMapper {
  static ClientDetails clientDetailsDbEntity(CD.Result details) =>
      ClientDetails(
          order: Order(
              description: details.order.description,
              price: details.order.price,
              orderDeliveryDate: details.order.orderDeliveryDate,
              discount: details.order.discount,
              additionalThings: details.order.additionalThings,
              delivered: details.order.delivered,
              paid: details.order.paid,
              advancePayment: details.order.advancePayment,
              advancePaymentType: details.order.advancePaymentType,
              totalProduct: details.order.totalProducts,
              clientId: null,
              userId: null,
              createdAt: details.order.createdAt,
              uid: details.order.uid),
          payments: [
            ...details.payments
                .map((e) => Payment(
                    payment: e.payment,
                    paymentType: e.paymentType,
                    orderId: e.orderId,
                    createdAt: e.createdAt))
                .toList()
          ]);

  static Client clientDbEntity(Datum client) => Client(
      name: client.name,
      fatherSurname: client.fatherSurname,
      motherSurname: client.motherSurname ?? "",
      userId: client.userId,
      createdAt: client.createdAt,
      uid: client.uid);
}
