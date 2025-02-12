import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///****** Edit_profile States *******************
@immutable
sealed class EditProfileState extends Equatable {
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileApiLoading extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileSuccess extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileFailed extends EditProfileState {
  final String error;

  const EditProfileFailed({required this.error});

  @override
  List<Object> get props => [error];
}
