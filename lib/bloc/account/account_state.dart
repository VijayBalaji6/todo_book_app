import 'package:equatable/equatable.dart';
import 'package:todo/model/account_model.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

/// Loading Account Data
class AccountLoading extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoaded extends AccountState {
  final AccountModel accountData;
  const AccountLoaded({required this.accountData});
  @override
  List<Object> get props => [];
}

class AccountError extends AccountState {
  final String errorMessage;

  const AccountError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

/// Sync Account Data
class AccountSyncing extends AccountState {}

class AccountSynced extends AccountState {}

class AccountSyncFailed extends AccountState {}
