part of 'payment_bloc.dart';

enum PaymentStatus {
  initial,
  loading,
  success,
  error,
  done,
}

class PaymentState extends Equatable {
  const PaymentState({this.payment, this.status = PaymentStatus.initial});

  final List<Payment>? payment;
  final PaymentStatus status;

  PaymentState copywith({List<Payment>? payment, PaymentStatus? status}) =>
      PaymentState(
          payment: payment ?? this.payment, status: status ?? this.status);

  @override
  List<Object?> get props => [payment];
}

extension PaymentStateX on PaymentState {
  bool get paymentLoading => status == PaymentStatus.loading;
  bool get paymentInitial => status == PaymentStatus.initial;
  bool get paymentError => status == PaymentStatus.error;
  bool get paymentSuccess => status == PaymentStatus.success;
}
