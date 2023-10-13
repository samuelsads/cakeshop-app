import 'package:bloc/bloc.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc(this.paymentRepository) : super(const PaymentState()) {
    on<AllPaymentEvent>(
      (event, emit) =>
          emit(state.copywith(payment: event.payment, status: event.status)),
    );
  }

  Future<void> getAll(String id) async {
    add(AllPaymentEvent(status: PaymentStatus.loading));
    final response = await paymentRepository.getAll(id, false);
    if (response.isNotEmpty) {
      add(AllPaymentEvent(status: PaymentStatus.success, payment: response));
    }
  }

  Future<Save> savePayment(Map<String, dynamic> data, bool update) async {
    Save response;
    response = await paymentRepository.savePayment(data);

    return response;
  }
}
