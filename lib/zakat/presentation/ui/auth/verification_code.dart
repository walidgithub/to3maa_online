import 'package:To3maa/zakat/presentation/router/arguments.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../router/app_router.dart';
import '../../shared/constant/app_constants.dart';
import '../../shared/constant/app_typography.dart';
import '../home_page/widgets/primary_button.dart';

class VerificationCode extends StatefulWidget {
  VerificationCodeArguments arguments;

  VerificationCode({super.key, required this.arguments});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {

  String verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Center(child: Image.asset(AppAssets.splash, width: 150.w)),
              SizedBox(height: AppConstants.heightBetweenElements),
              Text(
                AppStrings.verificationCode,
                style: AppTypography.kBold36.copyWith(color: AppColors.cNumber),
              ),
              SizedBox(height: 40.h),
              OtpTextField(
                numberOfFields: 5,
                autoFocus: true,
                fieldWidth: 50.0.w,
                enabledBorderColor: AppColors.cBorder,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  verificationCode = verificationCode;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text(
                              AppStrings.verificationCode,
                              style: AppTypography.kLight14
                                  .copyWith(color: AppColors.cBlack),
                            ),
                            content: Text(
                              '${AppStrings.verificationCodeIs} $verificationCode',
                              style: AppTypography.kLight14
                                  .copyWith(color: AppColors.cBlack),
                            ));
                      });
                }, // end onSubmit
              ),
              SizedBox(height: 30.h),
              PrimaryButton(
                  onTap: () {
                    if (widget.arguments.verifyCode == verificationCode) {
                      if (widget.arguments.pageName == 'EmailCheck') {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.resetPasswordRoute);
                      } else if (widget.arguments.pageName == 'Register') {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.homeRoute);
                      }
                    } else {
                      final snackBar = SnackBar(
                        duration:
                        Duration(milliseconds: AppConstants.durationOfSnackBar),
                        content: const Text(AppStrings.fakeOTP),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  text: AppStrings.confirm)
            ],
          ),
        ),
      ),
    );
  }
}
