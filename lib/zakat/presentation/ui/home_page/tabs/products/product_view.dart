import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductView extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String productDesc;
  final Function deleteProduct;
  final Function editProduct;
  final Function editPrice;
  const ProductView({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.deleteProduct,
    required this.editProduct,
    required this.editPrice,
  });

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final TextEditingController _editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: AppConstants.animation),
      child: SizedBox(
        height: 140.h,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.75,
              height: 120.h,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.cBackGround,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppConstants.radius),
                    bottomLeft: Radius.circular(AppConstants.radius)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.30,
                    child: Text(widget.productName,
                        style: AppTypography.kLight20
                            .copyWith(fontFamily: AppFonts.boldFontFamily),
                        overflow: TextOverflow.ellipsis),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.productPrice.toString(),
                        style: AppTypography.kLight16.copyWith(
                            fontFamily: AppFonts.boldFontFamily,
                            color: AppColors.cNumber),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'ج.م',
                        style: AppTypography.kLight16.copyWith(
                            fontFamily: AppFonts.boldFontFamily,
                            color: AppColors.cBlack),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.30,
                    child: Text(widget.productDesc,
                        style: AppTypography.kLight14.copyWith(
                            fontFamily: AppFonts.boldFontFamily,
                            color: AppColors.cGray),
                        overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
            ),
            Positioned(
                top: 30.h,
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    height: 35.h,
                    color: AppColors.cWhite,
                  ),
                )),
            Positioned(
                left: 15.w,
                top: 0,
                child: Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    widget.productImage,
                    width: widget.productImage == 'assets/images/package.png'
                        ? 60.w
                        : 120.w,
                  ),
                )),
            Positioned(
                top: 5.h,
                right: 10.w,
                child: SizedBox(
                    width: 100.w,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.editProduct();
                          },
                          child: Container(
                            width: 30.w,
                            height: 30.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.w, color: AppColors.cWhite),
                              borderRadius: BorderRadius.circular(4.w),
                              color: AppColors.cPrimary,
                              shape: BoxShape.rectangle,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 16.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.deleteProduct();
                          },
                          child: Container(
                            width: 30.w,
                            height: 30.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.w, color: AppColors.cPrimary),
                              borderRadius: BorderRadius.circular(4.w),
                              color: AppColors.cWhite,
                              shape: BoxShape.rectangle,
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              size: 20.w,
                              color: AppColors.cButton,
                            ),
                          ),
                        ),
                      ],
                    ))),
            Positioned(
              bottom: 5.h,
              left: 10.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppStrings.editPrice,
                    style: AppTypography.kLight11.copyWith(
                      fontFamily: AppFonts.qabasFontFamily,
                      color: AppColors.cButton,
                    ),
                  ),
                  SizedBox(
                    width: 5.h,
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 30.h,
                    child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _editController,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: AppFonts.boldFontFamily),
                        decoration:
                            const InputDecoration(border: InputBorder.none)),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'ج.م',
                    style: AppTypography.kLight14
                        .copyWith(fontFamily: AppFonts.boldFontFamily),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (int.parse(_editController.text.trim().toString()) <=
                          0) {
                        return;
                      }
                      widget.editPrice(_editController.text.trim());
                      _editController.text = '';
                    },
                    child: Container(
                        width: 50.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.w, color: AppColors.cPrimary),
                          borderRadius:
                              BorderRadius.circular(AppConstants.radius),
                          color: AppColors.cWhite,
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.save,
                            style: AppTypography.kLight11.copyWith(
                              fontFamily: AppFonts.qabasFontFamily,
                              color: AppColors.cButton,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
