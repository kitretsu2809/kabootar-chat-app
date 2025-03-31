import 'package:equatable/equatable.dart';
import 'package:firebasetesting/data/models/user_model.dart';
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? error;
  final UserModel? user;

  const AuthState({
     this.status = AuthStatus.initial,
    this.error,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? error,
    UserModel? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, error, user];
}




