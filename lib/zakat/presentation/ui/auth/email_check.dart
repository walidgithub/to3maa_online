import 'dart:math';

import 'package:To3maa/zakat/presentation/router/arguments.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/requests/auth/forgot_password_request.dart';
import '../../di/di.dart';
import '../../router/app_router.dart';
import '../../shared/constant/app_constants.dart';
import '../../shared/constant/app_typography.dart';
import '../../ui_components/loading_dialog.dart';
import '../home_page/cubit/zakat_cubit.dart';
import '../home_page/cubit/zakat_states.dart';
import '../home_page/widgets/primary_button.dart';
import 'components/auth_field.dart';

class EmailCheck extends StatefulWidget {
  const EmailCheck({super.key});

  @override
  State<EmailCheck> createState() => _EmailCheckState();
}

class _EmailCheckState extends State<EmailCheck> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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
                listener: (context, state) {
              if (state.zakatState == RequestState.updateLoading) {
                showLoading();
              } else if (state.zakatState == RequestState.updateError) {
                hideLoading();
                final snackBar = SnackBar(
                  duration:
                      Duration(milliseconds: AppConstants.durationOfSnackBar),
                  content: Text(state.zakatMessage),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state.zakatState == RequestState.updateDone) {
                hideLoading();
                ApiConstants.setToken = state.loginData.token;
                Navigator.of(context)
                    .pushReplacementNamed(Routes.verificationCodeRoute, arguments: VerificationCodeArguments(pageName: 'EmailCheck',verifyCode: state.forgotPasswordData.user.verifyCode));
              }
            }, builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 80.h),
                    Center(child: Image.asset(AppAssets.splash, width: 150.w)),
                    SizedBox(height: AppConstants.heightBetweenElements),
                    Text(AppStrings.forgotPass,
                        style: AppTypography.kBold24
                            .copyWith(color: AppColors.cNumber)),
                    Text(
                      AppStrings.sendEmail,
                      style: AppTypography.kLight14
                          .copyWith(color: AppColors.cBorder),
                    ),
                    SizedBox(height: 40.h),
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
                    SizedBox(height: 30.h),
                    PrimaryButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            Random random = Random();
                            int randomNumber = random.nextInt(1000);

                            ForgotPassRequest forgotPassRequest =
                                ForgotPassRequest(
                                    email: _emailController.text.trim(),
                                    verifyCode: randomNumber.toString());

                            await ZakatCubit.get(context)
                                .checkMail(forgotPassRequest);
                          }
                        },
                        text: AppStrings.send)
                  ],
                ),
              );
            }),
          ),
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
