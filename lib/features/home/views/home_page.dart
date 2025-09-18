import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hour_ain/core/constants/app_colors.dart';
import 'package:hour_ain/core/constants/app_images.dart';
import 'package:hour_ain/core/constants/app_typography.dart';
import 'package:hour_ain/features/home/model/Services.dart';
import '../cubit/add_to_booking_cubit.dart';
import '../cubit/add_to_booking_state.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../model/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Services _services = Services();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddToBookingCubit(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bgimage),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi, ", style: AppTypography.title2),
                    Text(
                      "Omar Farouk",
                      style: AppTypography.body2.copyWith(
                        fontFamily: GoogleFonts.sendFlowers().fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.logout_rounded, size: 30),
                    onPressed: () {},
                  ),
                ),
                backgroundColor: AppColors.transparentwo,
                automaticallyImplyLeading: false,
                toolbarHeight: 150,
                floating: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image(image: AssetImage(AppImages.applogo)),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Book Services: ",
                            style: AppTypography.title3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: _services.myservices.isEmpty
                            ? const Center(child: Text("No services available"))
                            : BlocBuilder<AddToBookingCubit, AddToBookingState>(
                                builder: (context, state) {
                                  List<Servicee> selectedServices = [];
                                  if (state is AddToBookingSuccessful) {
                                    selectedServices = state.selectedServices;
                                  } else if (state is AddToBookingFailed) {
                                    selectedServices = state.selectedServices;
                                  }

                                  return GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _services.myservices.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                        ),
                                    itemBuilder: (context, index) {
                                      final service =
                                          _services.myservices[index];

                                      final isSelected = selectedServices.any(
                                        (s) => s.id == service.id,
                                      );

                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<AddToBookingCubit>()
                                                .addToBooking(service);
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.primaryColorTrans
                                                  : AppColors.secondaryColor,
                                              border: isSelected
                                                  ? Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 2,
                                                    )
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image(
                                                        height: 50,
                                                        image: AssetImage(
                                                          service.logo,
                                                        ),
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => const Icon(
                                                              Icons.error,
                                                            ),
                                                      ),
                                                      Text(
                                                        service.name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppTypography
                                                            .caption1
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: AppColors.greyColor,
                        ),
                      ),
                       Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Choose Date: ",
                            style: AppTypography.title3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorTrans,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            calendarType: CalendarDatePicker2Type.single,
                            firstDayOfWeek: 1,
                            centerAlignModePicker: true,
                            controlsHeight: 48,
                            controlsTextStyle: AppTypography.body1.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            weekdayLabelTextStyle: AppTypography.caption1
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:Colors.black,
                                ),
                            dayTextStyle: AppTypography.body2.copyWith(
                              color: Colors.black,
                            ),
                            selectedDayHighlightColor: AppColors.secondaryColor,
                            selectedDayTextStyle: AppTypography.body2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            monthTextStyle: AppTypography.body2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            yearTextStyle: AppTypography.caption1.copyWith(
                              color: Colors.black,
                            ),
                            daySplashColor: AppColors.primaryColor,
                          ),
                          value: const [],
                          onValueChanged: (dates) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
