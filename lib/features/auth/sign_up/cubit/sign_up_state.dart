class SignUpState {}

class SignUpInitial extends SignUpState{}

class SignUpLoading extends SignUpState {}

class SignUpSuccessful extends SignUpState{}

class SignUpFailed extends SignUpState{
  String error;
  SignUpFailed({required this.error});
}
