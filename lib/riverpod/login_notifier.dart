import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/repository/api_functions.dart';
import 'package:stock_market_app/repository_models/login_failure_model.dart';
import 'package:stock_market_app/repository_models/login_model.dart';

int statusCode = 0;

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess({required this.token});
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    state = LoginLoading();
    try {
      var result = await loginApi(email: email, password: password);

      if (result is LoginModel) {
        state = LoginSuccess(token: result.jwt);
      } else if (result is LoginFailureModel) {
        print("login failure");
        state = LoginFailure(message: result.error.message);
      }
    } catch (error) {
      state = LoginFailure(message: '');
    }
  }
}

//provider
final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);
