class SignInState {}

class SignInInitial extends SignInState{}

class SignInLoading extends SignInState {}

class SignInSuccesful extends SignInState{}

class SignInFailed extends SignInState{
  String error;
  SignInFailed({required this.error});
}
