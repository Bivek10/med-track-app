part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String message;
  const AuthSuccess(this.message);
  @override
  List<Object> get props => [message];
}

final class Authenticated extends AuthState {
  final UserEntity user;
  final bool isUpdating;
  final String? message;
  final String? error;
  const Authenticated(this.user,
      {this.isUpdating = false, this.message, this.error});
  @override
  List<Object> get props => [user, isUpdating, message ?? '', error ?? ''];
}

final class Unauthenticated extends AuthState {
  final String? message;
  const Unauthenticated({this.message});
  @override
  List<Object> get props => [];
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
  @override
  List<Object> get props => [message];
}
