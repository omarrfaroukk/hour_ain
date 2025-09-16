import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hour_ain/core/constants/app_colors.dart';
import 'package:hour_ain/core/constants/app_routes.dart';
import 'package:hour_ain/core/constants/app_typography.dart';
import 'package:hour_ain/core/constants/app_images.dart';
import 'package:hour_ain/core/widgets/custom_textfield.dart';
import 'package:hour_ain/features/auth/sign_in/cubit/sign_in_cubit.dart';
import 'package:hour_ain/features/auth/sign_in/cubit/sign_in_state.dart';
import 'package:hour_ain/features/auth/widgets/custom_auth_button.dart';
import 'package:hour_ain/features/auth/widgets/join_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailcont = TextEditingController();
  final TextEditingController _passwordcont = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage(AppImages.applogo),
                        height: 120,
                      ),
                    ),
                    Container(
                      height: 400,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.transparentColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomAuthButton(
                                    txt: "Sign In",
                                    bgcolor: AppColors.primaryColor,
                                    txtColor: Colors.white,
                                    
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.signup,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomAuthButton(
                                      bgcolor: AppColors.whiteColor,
                                      txtColor: AppColors.primaryColor,
                                      txt: "Sign Up",
                                     
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CustomTextfield(
                              mycontroller: _emailcont,
                              label: "Email: ",
                            ),
                            CustomTextfield(
                              mycontroller: _passwordcont,
                              label: "Password: ",
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Forgot password? ",
                                style: AppTypography.caption1.copyWith(
                                  decoration: TextDecoration.underline,
                                ).merge(GoogleFonts.poppins()),
                              ),
                            ),
                            BlocListener<SignInCubit, SignInState>(
                              listener: (context, state) {
                                if (state is SignInSuccesful) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                }
                              },
                              child: Builder( // Added Builder to wrap the state-based widget
                                builder: (context) {
                                  final state = context.watch<SignInCubit>().state;
                                  if (state is SignInInitial) {
                                    return JoinButton(
                                      ontap: () {
                                        context.read<SignInCubit>().signin(
                                              _emailcont.text,
                                              _passwordcont.text,
                                            );
                                      },
                                      ch: Center(
                                        child: Text(
                                          "Sign In",
                                          style: AppTypography.body1.merge(GoogleFonts.poppins()),
                                        ),
                                      ),
                                    );
                                  }
                                  if (state is SignInLoading) {
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
                                        style: AppTypography.body1.merge(GoogleFonts.poppins()),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}