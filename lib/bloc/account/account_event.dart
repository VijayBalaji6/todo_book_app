import 'package:equatable/equatable.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class LoadAccountEvent extends AccountEvent {}

class SyncAccountEvent extends AccountEvent {}
