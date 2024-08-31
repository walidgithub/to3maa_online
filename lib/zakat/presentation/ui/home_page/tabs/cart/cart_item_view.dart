import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/entities/cart_items.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/cart/cart_product_item_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CartItemView extends StatefulWidget {
  final bool selected;
  final int zakatId;
  final int membersCount;
  final String zakatValue;
  final String total;
  final String remain;
  final Function deleteCart;
  final Function setSelected;
  const CartItemView({
    super.key,
    required this.selected,
    required this.zakatId,
    required this.membersCount,
    required this.zakatValue,
    required this.total,
    required this.remain,
    required this.deleteCart,
    required this.setSelected,
  });

  @override
  State<CartItemView> createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: Duration(milliseconds: AppConstants.animation),
        child: BlocConsumer<ZakatCubit, ZakatState>(
          listener: (context, state) async {
            if (state.zakatState ==
                RequestState.getZakatProductsByZakatIdLoading) {
            } else if (state.zakatState ==
                RequestState.getZakatProductsByZakatIdError) {
            } else if (state.zakatState ==
                RequestState.getZakatProductsByZakatIdLoaded) {
              cartProductsItems = state.zakatProductsByZakatIdList;
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  height: 115.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.cBackGround,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppConstants.radius),
                        bottomLeft: Radius.circular(AppConstants.radius)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.zakatValue.toString(),
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
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.membersCount.toString(),
                                    style: AppTypography.kLight16.copyWith(
                                        fontFamily: AppFonts.boldFontFamily,
                                        color: AppColors.cNumber),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    'أفراد',
                                    style: AppTypography.kLight16.copyWith(
                                        fontFamily: AppFonts.boldFontFamily,
                                        color: AppColors.cBlack),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.remain,
                                    style: AppTypography.kLight16.copyWith(
                                        fontFamily: AppFonts.boldFontFamily,
                                        color: AppColors.cBlack),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.remain.toString(),
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
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      widget.deleteCart();
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 30.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2.w,
                                            color: AppColors.cPrimary),
                                        borderRadius:
                                            BorderRadius.circular(4.w),
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
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 2.h,
                  child: GestureDetector(
                    onTap: () async {
                      await ZakatCubit.get(context).getZakatProductsByZakatId(
                          GetZakatProductsByZatatIdRequest(
                              zakatId: widget.zakatId));

                      widget.setSelected();

                      setState(() {
                        showDetails = true;
                      });
                    },
                    child: SvgPicture.asset(
                      AppAssets.arrowUp,
                      width: 25.w,
                    ),
                  ),
                ),
                showDetails && widget.selected
                    ? Positioned(
                        bottom: 2.h,
                        child: FadeInUp(
                          duration:
                              Duration(milliseconds: AppConstants.animation),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.65,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            height: 130.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.w, color: AppColors.cPrimary),
                              borderRadius:
                                  BorderRadius.circular(AppConstants.radius),
                              color: AppColors.cWhite,
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDetails = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 25.w,
                                  ),
                                ),
                                const Divider(),
                                Expanded(
                                  child: state
                                          .zakatProductsByZakatIdList.isNotEmpty
                                      ? SingleChildScrollView(
                                          child: ListView.separated(
                                              itemCount: state
                                                  .zakatProductsByZakatIdList
                                                  .length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (BuildContext cartContext,
                                                          int index) =>
                                                      const SizedBox(height: 0),
                                              itemBuilder:
                                                  (BuildContext cartContext,
                                                      int index) {
                                                return CartItemProductView(
                                                  productName: state
                                                      .zakatProductsByZakatIdList[
                                                          index]
                                                      .productName,
                                                  productDesc: state
                                                      .zakatProductsByZakatIdList[
                                                          index]
                                                      .productDesc,
                                                  productQuantity: state
                                                      .zakatProductsByZakatIdList[
                                                          index]
                                                      .productQuantity
                                                      .toString(),
                                                );
                                              }),
                                        )
                                      : Container(),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ));
  }
}
