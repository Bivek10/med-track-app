import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/utils/typedf/index.dart';
import '../../../../injector.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthBloc(this.authUsecase) : super(AuthInitial()) {
    on<AuthStatus>(_getProfile);
    on<AuthSignIn>(_signIn);
    on<AuthSignUp>(_signUp);
    on<AuthSignOut>(_signOut);
    add(AuthStatus());
  }

  Future<void> _signUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await authUsecase.callSignUp(event.userMap);
    res.match(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(Authenticated(r.data)),
    );
  }

  Future<void> _getProfile(AuthStatus event, Emitter<AuthState> emit) async {
    final res = await authUsecase.callProfile();
    res.match(
      (l) => emit(const Unauthenticated()),
      (r) => emit(Authenticated(r.data)),
    );
  }

  Future<void> _signIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await authUsecase.callSignIn(event.userMap);
    res.match(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(Authenticated(r.data)),
    );
  }

  Future<void> _signOut(AuthSignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await inject<FlutterSecureStorage>().deleteAll();
    emit(const Unauthenticated());
  }
}
