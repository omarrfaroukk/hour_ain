import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hour_ain/features/home/model/service.dart';
import 'add_to_booking_state.dart';

class AddToBookingCubit extends Cubit<AddToBookingState> {
  AddToBookingCubit() : super(AddToBookingInitial());

  List<Servicee> selectedServices = [];

  void addToBooking(Servicee s) {
    for (int i = 0; i < selectedServices.length; i++) {
      if (selectedServices[i].id == s.id) {
        removeFromBooking(s);
        return;
      }
    }
    selectedServices.add(s);
    emit(AddToBookingSuccessful(List.from(selectedServices)));
  }

  void removeFromBooking(Servicee s) {
    selectedServices.remove(s);
    emit(AddToBookingSuccessful(List.from(selectedServices)));
  }
}
