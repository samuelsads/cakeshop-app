import 'package:cakeshopapp/domain/entities/cliente_details.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/presentation/blocs/client_bloc/client_bloc.dart';

class ViewmodelClient {
  double totalClient(List<ClientDetails> details) {
    double total = 0.0;
    for (var element in details) {
      final Order order = element.order;
      total += order.price;
    }

    return total;
  }

  double debtPaymentClient(List<ClientDetails> details) {
    double debt = 0.0;

    for (var element in details) {
      final Order order = element.order;
      if (!order.paid) {
        final List<Payment> payments = element.payments;

        for (var element in payments) {
          debt += element.payment;
        }

        if (payments.isEmpty) {
          debt += order.price;
        }
      }
    }
    return debt;
  }

  double totalPaymentClient(List<ClientDetails> details) {
    double total = 0.0;

    for (var element in details) {
      final Order order = element.order;
      if (order.paid) {
        total += element.order.price;
      } else {
        final List<Payment> payments = element.payments;
        for (var element in payments) {
          total += element.payment;
        }
      }
    }

    return total;
  }

  Future<Save> updateClient(
      Map<String, dynamic> data, ClientBloc bloc, bool update) async {
    return await bloc.saveClient(data, update);
  }

  Future<Save> saveOrder(
      Map<String, dynamic> data, ClientBloc bloc, bool update) async {
    return await bloc.saveClient(data, update);
  }

  Future<void> getAllClients(int start, int limit, ClientBloc bloc) async {
    await bloc.allClient(start, limit);
  }

  Future<List<ClientDetails>> clientDetails(String id, ClientBloc bloc) async {
    return await bloc.clientRepository.clientDetails(id);
  }
}
