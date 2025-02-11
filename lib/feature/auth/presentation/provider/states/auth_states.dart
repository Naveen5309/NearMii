import 'package:NearMii/config/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///****** Login States *******************
@immutable
sealed class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthApiLoading extends AuthState {
  final AuthType authType;

  const AuthApiLoading({
    required this.authType,
  });

  @override
  List<Object> get props => [authType];
}

class AuthApiSuccess extends AuthState {
  final AuthType authType;
  const AuthApiSuccess({
    required this.authType,
  });

  @override
  List<Object> get props => [authType];
}

class AuthApiFailed extends AuthState {
  final AuthType authType;

  final String error;

  const AuthApiFailed({
    required this.error,
    required this.authType,
  });

  @override
  List<Object> get props => [error, authType];
}

///****** Sinup States *******************
@immutable
sealed class SignUpState extends Equatable {
  const SignUpState();
}

class SignupInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SinupApiLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SinupSuccess extends SignUpState {
  @override
  List<Object> get props => [];
}

class SinupFailed extends SignUpState {
  final String error;

  const SinupFailed({required this.error});

  @override
  List<Object> get props => [error];
}
