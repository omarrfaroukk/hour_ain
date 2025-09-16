import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signup(
    String email,
    String password,
    int number,
    String username,
  ) async {
    try {
      emit(SignUpLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(SignUpSuccessful());
    } catch (e) {
      emit(SignUpFailed(error: e.toString()));
    }
  }
}
