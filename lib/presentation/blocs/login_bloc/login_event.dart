part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAccessEvent extends LoginEvent {
  final Login? login;
  final LoginStatus status;

  const LoginAccessEvent({this.login, this.status = LoginStatus.initial});
}
