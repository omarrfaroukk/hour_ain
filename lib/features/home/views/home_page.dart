import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hour_ain/core/constants/app_colors.dart';
import 'package:hour_ain/core/constants/app_images.dart';
import 'package:hour_ain/core/constants/app_typography.dart';
import 'package:hour_ain/features/home/model/Services.dart';
import '../cubit/add_to_booking_cubit.dart';
import '../cubit/add_to_booking_state.dart';
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
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Select Services",
                            style: AppTypography.title3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
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

                                      // 🔑 check if this service is in the selected list
                                      final isSelected = selectedServices.any(
                                        (s) => s.id == service.id,
                                      );

                                      return Padding(
                                        padding: const EdgeInsets.all(12),
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
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ],
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
