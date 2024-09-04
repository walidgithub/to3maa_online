import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/enums.dart';
import '../../di/di.dart';
import '../../router/app_router.dart';
import '../../shared/constant/app_constants.dart';
import '../../shared/constant/app_typography.dart';
import '../../ui_components/loading_dialog.dart';
import '../home_page/cubit/zakat_cubit.dart';
import '../home_page/cubit/zakat_states.dart';
import '../home_page/widgets/primary_button.dart';
import 'components/auth_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                    Navigator.of(context).pushReplacementNamed(Routes.signInRoute);
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 80.h),
                        Center(child: Image.asset(AppAssets.splash,width: 150.w)),
                        SizedBox(height: AppConstants.heightBetweenElements),
                        Text(AppStrings.resetPassword,
                            style: AppTypography.kBold24
                                .copyWith(color: AppColors.cNumber)),
                        SizedBox(height: 40.h),
                        AuthField(
                          hintText: AppStrings.password,
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
                          hintText: AppStrings.passwordCheck,
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
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).pushReplacementNamed(Routes.signInRoute);
                              }
                            },
                            text: AppStrings.save)
                      ],
                    ),
                  );
                } ),
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
