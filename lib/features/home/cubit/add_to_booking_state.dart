import 'package:hour_ain/features/home/model/service.dart';

class AddToBookingState {
  final List<Servicee> selectedServices;
  AddToBookingState(this.selectedServices);
}

class AddToBookingInitial extends AddToBookingState {
  AddToBookingInitial() : super([]);
}

class AddToBookingSuccessful extends AddToBookingState {
  AddToBookingSuccessful(super.selectedServices);
}

class AddToBookingFailed extends AddToBookingState {
  AddToBookingFailed(super.selectedServices);
}
