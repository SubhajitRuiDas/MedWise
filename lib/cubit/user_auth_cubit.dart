import 'package:bloc/bloc.dart';
import 'package:med_tech_app/cubit/user_auth_state.dart';


class UserAuthCubit extends Cubit<UserAuthState> {
  UserAuthCubit() : super(UserAuthState(authOnProcess: false));

  void startAuthenticationProcess() => emit(UserAuthState(authOnProcess: true));

  void endAuthenticationProcess() => emit(UserAuthState(authOnProcess: false));
}
