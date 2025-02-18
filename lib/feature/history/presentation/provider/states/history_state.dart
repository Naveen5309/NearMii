import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///****** History States *******************
@immutable
sealed class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryApiLoading extends HistoryState {
  const HistoryApiLoading();

  @override
  List<Object> get props => [];
}

class HistoryApiSuccess extends HistoryState {
  const HistoryApiSuccess();
  @override
  List<Object> get props => [];
}

class HistoryApiFailed extends HistoryState {
  final String error;

  const HistoryApiFailed({required this.error});

  @override
  List<Object> get props => [error];
}
