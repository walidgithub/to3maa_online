import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../router/app_router.dart';
import '../../shared/constant/app_constants.dart';
import '../../shared/constant/app_typography.dart';
import '../../ui_components/custom_animation.dart';
import '../../ui_components/loading_dialog.dart';
import '../home_page/widgets/custom_text_button.dart';
import '../home_page/widgets/primary_button.dart';
import 'components/auth_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isEmailCorrect = false;
  bool isNameCorrect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _formKey,
            child: FadeAnimation(
              delay: 1,
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  Center(child: Image.asset(AppAssets.splash,width: 100.w)),
                  SizedBox(height: 30.h),
                  Text(AppStrings.signUp,
                      style: AppTypography.kBold30
                          .copyWith(color: AppColors.cNumber)),
                  SizedBox(height: 30.h),
                  AuthField(
                    controller: _usernameController,
                    hintText: AppStrings.username,
                    isFieldValidated: isNameCorrect,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      isNameCorrect = validateName(value);
                      setState(() {});
                    },
                    validator: (value) {
                      if(!validateName(value!)){
                        return AppStrings.enterValidUsername;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppConstants.heightBetweenElements),
                  AuthField(
                    controller: _emailController,
                    hintText: AppStrings.email,
                    keyboardType: TextInputType.emailAddress,
                    isFieldValidated: isEmailCorrect,
                    onChanged: (value) {
                      setState(() {});
                      isEmailCorrect = validateEmail(value);
                    },
                    validator: (value) {
                      if (!validateEmail(value!)) {
                        return AppStrings.signIn;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppConstants.heightBetweenElements),
                  AuthField(
                    hintText: AppStrings.passwordCheck,
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    isPasswordField: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterYourPass;
                      } else if (value.length < 6) {
                        return AppStrings.enterPass6Characters;
                      } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$')
                          .hasMatch(value)) {
                        return AppStrings.validPass;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppConstants.heightBetweenElements),
                  AuthField(
                    hintText: AppStrings.password,
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    isPasswordField: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterYourPass;
                      } else if (value.length < 6) {
                        return AppStrings.enterPass6Characters;
                      } else if (_confirmPasswordController.text != _passwordController.text) {
                        return AppStrings.confirmPassword;
                      } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$')
                          .hasMatch(value)) {
                        return AppStrings.validPass;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  PrimaryButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          showLoading();
                          await Future.delayed(const Duration(seconds: 3));
                          hideLoading();
                          Navigator.of(context).pushReplacementNamed(Routes.verificationCodeRoute);
                        }
                      },
                      text: AppStrings.signUp),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.alreadyUser,
                          style: AppTypography.kLight14.copyWith(
                            color: AppColors.cBorder,
                          )),
                      SizedBox(
                        width: AppConstants.heightBetweenElements,
                      ),
                      CustomTextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(Routes.signInRoute);
                        },
                        text: AppStrings.signIn,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateName(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      final nameRegex = RegExp(r'^[a-zA-Z]+$');
      return nameRegex.hasMatch(value);
    }
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
