import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectship_app/model/src_address_model.dart';
import 'package:perfectship_app/model/usercredit_model.dart';

import 'package:perfectship_app/repository/address_repository.dart';
import 'package:perfectship_app/repository/bank_repository.dart';

import 'package:perfectship_app/repository/new_repository/user_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/bank_model.dart';
import '../../model/new_model/user_data_model.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final BankRepository bankRepository;
  final AddressRepository addressRepository;
  UserDataBloc({required this.bankRepository, required this.addressRepository}) : super(UserDataLoading()) {
    on<UserDataInitialEvent>(_onLoadGetUserdata);
    //on<UserdataAfterSendEvent>(_onLoadGetAftersenddata);
  }

  void _onLoadGetUserdata(UserDataInitialEvent event, Emitter<UserDataState> emit) async {
    print('on user bloc');
    await UserDataRepository().getUserData().then((value) => emit(UserDataLoaded(userdatamodel: value)));
    // final rescreit = await getUserDataRepository.getUserCredit(response.userId!);
    // final responsebank = await bankRepository.getBank();

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('accountname', response.accountName!);
    // preferences.setString('accountnumber', response.accountNumber!);
    // preferences.setString('userid', response.userId!.toString());
    //final responsesrcaddress = await addressRepository.getSrcAddress();
  }

  // void _onLoadGetAftersenddata(UserdataAfterSendEvent event, Emitter<UserDataState> emit) async {
  //   emit(UserDataLoading());
  //   final response = await getUserDataRepository.getUser();
  //   final rescreit = await getUserDataRepository.getUserCredit(response.userId!);
  //   final responsebank = await bankRepository.getBank();
  //   final responsesrcaddress = await addressRepository.getSrcAddress();
  //   print('bloc res = ${response.accountName}');
  //   print('rescredit = ${rescreit.credit}');
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('accountname', response.accountName!);
  //   preferences.setString('accountnumber', response.accountNumber!);
  //   preferences.setString('userid', response.userId!.toString());

  //   emit(UserDataLoaded(srcaddressmodel: responsesrcaddress, userdatamodel: response, usercreditmodel: rescreit, bank: responsebank));
  // }

  // void _onLoadgetBankId(GetbankdataEvent event, Emitter<UserDataState> emit) {}
}
