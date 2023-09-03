import 'package:cakeshopapp/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:intl/intl.dart';

class ViewmodelOrders {
  Future<void> getAllOrders(
      int start, int limit, bool delivered, OrderBloc bloc) async {
    await bloc.allOrders(start, limit, delivered);
  }

  String formattedDate(DateTime date) {
    Intl.defaultLocale = 'es';
    String formattedDate = DateFormat('EEEE d MMMM yyyy', 'es').format(date);
    return formattedDate;
  }
}
