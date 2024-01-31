import 'package:bloc/bloc.dart';
import 'package:todo/bloc/account/account_event.dart';
import 'package:todo/bloc/account/account_state.dart';
import 'package:todo/model/account_model.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountLoading()) {
    on<LoadAccountEvent>(_onLoadAccount);
    on<SyncAccountEvent>(_syncAccount);
  }

  void _onLoadAccount(LoadAccountEvent event, Emitter<AccountState> emit) {
    emit(AccountLoading());
    try {
      emit(AccountLoaded(
          accountData: AccountModel(
              userName: '',
              accountId: '',
              loginType: '',
              userProfileImage: '')));
    } catch (e) {
      emit(const AccountError(errorMessage: ""));
    }
  }

  void _syncAccount(SyncAccountEvent event, Emitter<AccountState> emit) {}
}
