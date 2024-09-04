import 'package:To3maa/zakat/presentation/router/arguments.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/preferences/app_pref.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/requests/auth/login_request.dart';
import '../../di/di.dart';
import '../../router/app_router.dart';
import '../../shared/constant/app_constants.dart';
import '../../shared/constant/app_typography.dart';
import '../../ui_components/custom_animation.dart';
import '../../ui_components/loading_dialog.dart';
import '../home_page/cubit/zakat_cubit.dart';
import '../home_page/widgets/custom_text_button.dart';
import '../home_page/widgets/primary_button.dart';
import 'components/auth_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AppPreferences _appPreferences = sl<AppPreferences>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isEmailCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider(
              create: (context) => sl<ZakatCubit>(),
              child: BlocConsumer<ZakatCubit, ZakatState>(
                  listener: (context, state) async {
                if (state.zakatState == RequestState.loginLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.loginError) {
                  hideLoading();
                  final snackBar = SnackBar(
                    duration:
                        Duration(milliseconds: AppConstants.durationOfSnackBar),
                    content: Text(state.zakatMessage),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (state.zakatState == RequestState.loginDone) {
                  hideLoading();
                  ApiConstants.setToken = state.loginData.token;
                  await _appPreferences.setUserLoggedIn();
                  Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
                }
              }, builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: FadeAnimation(
                    delay: 1,
                    child: Column(
                      children: [
                        SizedBox(height: 80.h),
                        Center(
                            child: Image.asset(
                          AppAssets.splash,
                          width: 100.w,
                        )),
                        SizedBox(height: 30.h),
                        Text(AppStrings.signIn,
                            style: AppTypography.kBold30
                                .copyWith(color: AppColors.cNumber)),
                        SizedBox(height: 23.h),
                        AuthField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          isFieldValidated: isEmailCorrect,
                          onChanged: (value) {
                            setState(() {});
                            isEmailCorrect = validateEmail(value);
                          },
                          hintText: AppStrings.email,
                          validator: (value) {
                            if (!validateEmail(value!)) {
                              return AppStrings.enterValidEmail;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppConstants.heightBetweenElements),
                        AuthField(
                          hintText: AppStrings.password,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          isForgetButton: true,
                          isPasswordField: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.enterYourPass;
                            } else if (value.length < 6) {
                              return AppStrings.enterPass6Characters;
                            } else if (!RegExp(
                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$')
                                .hasMatch(value)) {
                              return AppStrings.validPass;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 0.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomTextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.emailCheckRoute);
                            },
                            text: AppStrings.forgotPassQ,
                            color: AppColors.cNumber,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        PrimaryButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                LoginRequest loginRequest = LoginRequest(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());

                                await ZakatCubit.get(context)
                                    .login(loginRequest);
                              }
                            },
                            text: AppStrings.signIn),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppStrings.newUser,
                                style: AppTypography.kLight14.copyWith(
                                  color: AppColors.cBorder,
                                )),
                            SizedBox(
                              width: AppConstants.heightBetweenElements,
                            ),
                            CustomTextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(Routes.signUpRoute);
                              },
                              text: AppStrings.signUp,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })),
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );
      return emailRegex.hasMatch(value);
    }
  }
}
