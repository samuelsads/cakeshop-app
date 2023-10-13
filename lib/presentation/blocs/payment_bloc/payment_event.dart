part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class AllPaymentEvent extends PaymentEvent {
  final List<Payment>? payment;
  final PaymentStatus status;

  const AllPaymentEvent({this.payment, this.status = PaymentStatus.initial});
}
