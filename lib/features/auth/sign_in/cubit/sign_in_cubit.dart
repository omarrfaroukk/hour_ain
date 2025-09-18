import 'package:bloc/bloc.dart';
import 'package:hour_ain/features/auth/sign_in/cubit/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signin(String email, String password) async {
    try {
      emit(SignInLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(SignInSuccesful());
    } catch (e) {
      emit(SignInFailed(error: e.toString()));
    }
  }
}
