import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestedView extends StatelessWidget {
  final String imagePath;
  final String imageName;
  final String imageDesc;
  final Function addSuggested;
  final bool selected;
  final int id;
  const SuggestedView(
      {super.key,
      required this.imagePath,
      required this.imageName,
      required this.imageDesc,
      required this.addSuggested,
      required this.selected,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
        duration: Duration(milliseconds: AppConstants.animation),
        child: GestureDetector(
          onTap: () {
            addSuggested(id);
          },
          child: Stack(
            children: [
              SizedBox(
                height: 100.h,
                width: 70.h,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.w,
                        color: selected
                            ? AppColors.cButton
                            : AppColors.cBackGround),
                    color: AppColors.cBackGround,
                    borderRadius: BorderRadius.circular(AppConstants.radius),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: 50.w,
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 5.h,
                  child: SizedBox(
                      width: 70.w,
                      child: Center(
                        child: Text(
                          imageDesc,
                          style: AppTypography.kBold14
                              .copyWith(color: AppColors.cBlack),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 5.h,
                  child: SizedBox(
                      width: 70.w,
                      child: Center(
                        child: Text(
                          imageName,
                          style: AppTypography.kBold14
                              .copyWith(color: AppColors.cNumber),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))),
            ],
          ),
        ));
  }
}
