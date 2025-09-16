import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hour_ain/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:hour_ain/features/auth/sign_up/cubit/sign_up_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../widgets/custom_auth_button.dart';
import '../../widgets/join_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailcont = TextEditingController();
  final TextEditingController _passwordcont = TextEditingController();
  final TextEditingController _confirmpasswordcont = TextEditingController();
  final TextEditingController _phonenumbercont = TextEditingController();
  final TextEditingController _usernamecont = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bgimage),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 600,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.transparentColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.signin,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomAuthButton(
                                    txt: "Sign In",
                                    bgcolor: AppColors.whiteColor,
                                    txtColor: AppColors.primaryColor,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomAuthButton(
                                  bgcolor: AppColors.primaryColor,
                                  txtColor: AppColors.whiteColor,
                                  txt: "Sign Up",
                                ),
                              ),
                            ],
                          ),
                          CustomTextfield(
                            mycontroller: _usernamecont,
                            label: "Username: ",
                          ),
                          CustomTextfield(
                            mycontroller: _phonenumbercont,
                            label: "Phone Number: ",
                          ),

                          CustomTextfield(
                            mycontroller: _emailcont,
                            label: "Email: ",
                          ),
                          CustomTextfield(
                            mycontroller: _passwordcont,
                            label: "Password: ",
                          ),
                          CustomTextfield(
                            mycontroller: _confirmpasswordcont,
                            label: "Confirm Password: ",
                          ),

                          BlocListener<SignUpCubit, SignUpState>(
                            listener: (context, state) {
                              if (state is SignUpSuccessful) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              }
                            },
                            child: Builder(
                              // Added Builder to wrap the state-based widget
                              builder: (context) {
                                final state = context
                                    .watch<SignUpCubit>()
                                    .state;
                                if (state is SignUpInitial) {
                                  return JoinButton(
                                    ontap: () {
                                      context.read<SignUpCubit>().signup(
                                        _emailcont.text,
                                        _passwordcont.text,
                                        int.parse(_phonenumbercont.text),
                                        _usernamecont.text,
                                      );
                                    },
                                    ch: Center(
                                      child: Text(
                                        "Sign Up",
                                        style: AppTypography.body1.merge(
                                          GoogleFonts.poppins(),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (state is SignUpLoading) {
                                  return Center(
                                    child: SpinKitThreeInOut(
                                      size: 22,
                                      color: AppColors.primaryColor,
                                    ),
                                  );
                                }
                                return JoinButton(
                                  ontap: () {},
                                  ch: Center(
                                    child: Text(
                                      "Sign In",
                                      style: AppTypography.body1.merge(
                                        GoogleFonts.poppins(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
