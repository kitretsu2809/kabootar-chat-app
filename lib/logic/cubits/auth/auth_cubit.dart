import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetesting/data/models/user_model.dart';
import 'package:firebasetesting/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authStateSubscription;
  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState()) {
          _init();
  }

  void _init() {
    _authStateSubscription?.cancel();
    _authStateSubscription = _authRepository.authStateChanges.listen((user) async{
      if (user != null) {
        try {
          final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
          emit(AuthState(status: AuthStatus.authenticated, user: UserModel.fromFirestore(userDoc)));
        } catch (e) {
          emit(const AuthState(status: AuthStatus.error, error: 'Failed to fetch user data.'));
        }
      } else {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      }
    });
  }

}
