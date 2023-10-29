import 'package:bloc/bloc.dart';
import 'package:cakeshopapp/domain/entities/login.dart';
import 'package:cakeshopapp/domain/repositories/login_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(const LoginState()) {
    on<LoginAccessEvent>(
      (event, emit) =>
          emit(state.copyWith(login: event.login, status: event.status)),
    );
  }

  Future<Login> verifyToken(String token) async {
    final data = await loginRepository.verifyToken(token);
    if (data.success) {
      add(LoginAccessEvent(login: data));
    }

    return data;
  }

  Future<void> login(String email, String password) async {
    add(const LoginAccessEvent(status: LoginStatus.loading));
    final data = await loginRepository.login(email, password);
    if (!data.success) {
      add(const LoginAccessEvent(status: LoginStatus.error));
    } else {
      add(LoginAccessEvent(login: data, status: LoginStatus.success));
    }
  }
}
