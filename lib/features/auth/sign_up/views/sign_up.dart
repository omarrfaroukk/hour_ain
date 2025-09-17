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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: AssetImage(AppImages.applogo),
                        height: 200,
                      ),
                      Container(
                        height: 650,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                  label: "Display Name: ",
                                  val: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Display name is required";
                                    }
                                    if (value.length < 3) {
                                      return "Display name must be at least 3 characters";
                                    }
                                    if (!RegExp(r'^[a-zA-Z0-9_ ]+$')
                                        .hasMatch(value)) {
                                      return "Only letters, numbers, spaces, and underscores are allowed";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextfield(
                                  mycontroller: _phonenumbercont,
                                  label: "Phone Number: ",
                                  val: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Phone number is required";
                                    }

                                    if (!RegExp(r'^\d{10,15}$')
                                        .hasMatch(value)) {
                                      return "Enter a valid phone number";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextfield(
                                  mycontroller: _emailcont,
                                  label: "Email: ",
                                  val: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Email is required";
                                    }
                                    // Simple email regex
                                    String pattern =
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                    RegExp regex = RegExp(pattern);
                                    if (!regex.hasMatch(value)) {
                                      return "Enter a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextfield(
                                  mycontroller: _passwordcont,
                                  label: "Password: ",
                                  val: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password is required";
                                    }
                                    if (value.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    }
                                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                      return "Password must contain at least one uppercase letter";
                                    }
                                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                                      return "Password must contain at least one number";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextfield(
                                  mycontroller: _confirmpasswordcont,
                                  label: "Confirm Password: ",
                                  val: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please confirm your password";
                                    }
                                    if (value != _passwordcont.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
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
                                      final state =
                                          context.watch<SignUpCubit>().state;
                                      if (state is SignUpInitial) {
                                        return JoinButton(
                                          ontap: () {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              context
                                                  .read<SignUpCubit>()
                                                  .signup(
                                                    _emailcont.text,
                                                    _passwordcont.text,
                                                    int.parse(
                                                        _phonenumbercont.text),
                                                    _usernamecont.text,
                                                  );
                                            }
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
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
