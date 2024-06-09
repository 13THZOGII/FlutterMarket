import 'package:flutter_bloc/flutter_bloc.dart';
//BURASU BEYİN
part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit(super.initialState);


  changeLanguage({required String language}){
    final newState = ClientState(
    language: language,
    DarkMode: state.DarkMode,
    );
    emit(newState);
  }

  changeDarkMode({required bool DarkMode}){
    final newState = ClientState(
      language: state.language,
      DarkMode: DarkMode,
      );
      emit(newState);
  }

}
