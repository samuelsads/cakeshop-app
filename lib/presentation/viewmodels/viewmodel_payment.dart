import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/presentation/blocs/payment_bloc/payment_bloc.dart';

class ViewmodelPayment {
  String typePayment(int type) {
    switch (type) {
      case 1:
        return "Efectivo";
      default:
        return "Pago con tarjeta";
    }
  }

  Future<void> getAll(String data, PaymentBloc bloc) async {
    return await bloc.getAll(data);
  }

  Future<Save> saveOrder(
      Map<String, dynamic> data, PaymentBloc bloc, bool update) async {
    return await bloc.savePayment(data, update);
  }
}
