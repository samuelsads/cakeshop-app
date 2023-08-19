part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, error, done }

class LoginState extends Equatable {
  const LoginState({this.login, this.status = LoginStatus.initial});

  final Login? login;
  final LoginStatus status;

  LoginState copyWith({Login? login, LoginStatus? status}) =>
      LoginState(login: login ?? this.login, status: status ?? this.status);

  @override
  List<Object?> get props => [login, status];

  @override
  String toString() {
    return 'Login: $login, status: $status';
  }
}

extension LoginStateX on LoginState {
  bool get loginLoading => status == LoginStatus.loading;
  bool get loginInitial => status == LoginStatus.initial;
  bool get loginError => status == LoginStatus.error;
  bool get loginSuccess => status == LoginStatus.success;
  bool get loginDone => status == LoginStatus.done;
}
