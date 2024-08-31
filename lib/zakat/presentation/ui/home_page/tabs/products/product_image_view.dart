import 'package:flutter/material.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageView extends StatefulWidget {
  final String imagePath;
  final String imageName;
  final bool activeImage;
  final Function(String) makeActive;
  const ProductImageView(
      {super.key,
      required this.imagePath,
      required this.imageName,
      required this.activeImage,
      required this.makeActive});

  @override
  State<ProductImageView> createState() => _ProductImageViewState();
}

class _ProductImageViewState extends State<ProductImageView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.makeActive(widget.imagePath);
      },
      child: Stack(
        children: [
          Container(
            height: 100.h,
            width: 100.h,
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.radius),
                border: Border.all(
                    color: widget.activeImage
                        ? AppColors.cPrimary
                        : AppColors.cWhite,
                    width: 2.w),
                color: AppColors.cBackGround),
            child: Image.asset(widget.imagePath),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 5.h,
              child: SizedBox(
                  width: 70.w,
                  child: Center(
                    child: Text(
                      widget.imageName,
                      style: AppTypography.kBold14
                          .copyWith(color: AppColors.cNumber),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))),
        ],
      ),
    );
  }
}
