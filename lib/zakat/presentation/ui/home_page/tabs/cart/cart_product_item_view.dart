import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter/material.dart';

class CartItemProductView extends StatelessWidget {
  final String productName;
  final String productQuantity;
  final String productDesc;
  const CartItemProductView(
      {super.key,
      required this.productName,
      required this.productQuantity,
      required this.productDesc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '- $productName',
              style: AppTypography.kBold16,
            ),
            Text(
              '$productQuantity  ${AppStrings.sa3}',
              style: AppTypography.kLight14,
            ),
          ],
        ),
        Text(
          productDesc,
          style: AppTypography.kLight13.copyWith(color: AppColors.cGray),
        ),
      ],
    );
  }
}
