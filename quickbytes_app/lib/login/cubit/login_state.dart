part of 'login_cubit.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  final LoginStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum LoginStatus {
  initial,
  success,
  failure,
  inProgress,
}

extension LoginStatusEx on LoginStatus {
  bool get isFailure => this == LoginStatus.failure;
}
