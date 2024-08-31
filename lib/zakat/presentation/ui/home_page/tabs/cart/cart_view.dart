import 'dart:async';
import 'package:To3maa/core/utils/enums.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To3maa/zakat/domain/entities/cart_items.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/cart/cart_item_view.dart';
import 'package:To3maa/zakat/presentation/ui_components/loading_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    getAllZakat();
    super.initState();
  }

  List<Cart> cart = [];

  Future<void> getAllZakat() async {
    await ZakatCubit.get(context).getAllZakat();
  }

  Future<void> deleteAll() async {
    await ZakatCubit.get(context).deleteAllZakat();
  }

  double getTotal() {
    double total = 0.0;
    for (var x in cartItems) {
      total = total + double.parse(x.zakatValue);
    }
    return total;
  }

  double getRemain() {
    double remain = 0.0;
    for (var x in cartItems) {
      remain = remain + double.parse(x.remainValue);
    }
    return remain;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cWhite,
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          title: FadeInLeft(
            duration: Duration(milliseconds: AppConstants.animation),
            child: Text(
              AppStrings.cart,
              style: AppTypography.kLight20
                  .copyWith(fontFamily: AppFonts.boldFontFamily),
            ),
          ),
        ),
        backgroundColor: AppColors.cWhite,
        body: BlocConsumer<ZakatCubit, ZakatState>(
            listener: (context, state) async {
          if (state.zakatState == RequestState.zakatLoading) {
            showLoading();
          } else if (state.zakatState == RequestState.zakatError) {
            hideLoading();
          } else if (state.zakatState == RequestState.zakatLoaded) {
            cartItems = state.zakatList;
            for (var x in state.zakatList) {
              cart.add(Cart(
                  id: x.id,
                  membersCount: x.membersCount,
                  remainValue: x.remainValue,
                  selected: false,
                  zakatValue: x.zakatValue));
            }
            hideLoading();
          } else if (state.zakatState == RequestState.deleteLoading) {
            showLoading();
          } else if (state.zakatState == RequestState.deleteError) {
            hideLoading();
          } else if (state.zakatState == RequestState.deleteDone) {
            hideLoading();
          }
        }, builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: cart.isNotEmpty
                      ? SingleChildScrollView(
                          child: ListView.separated(
                              itemCount: cart.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder:
                                  (BuildContext cartContext, int index) =>
                                      SizedBox(
                                        height: 20.h,
                                      ),
                              itemBuilder:
                                  (BuildContext cartContext, int index) {
                                DeleteZakatRequest deleteZakatRequest =
                                    (DeleteZakatRequest(
                                        id: cartItems[index].id));
                                DeleteZakatProductsRequest
                                    deleteZakatProductsRequest =
                                    (DeleteZakatProductsRequest(
                                        id: cartItems[index].id));

                                return CartItemView(
                                  selected: cart[index].selected!,
                                  zakatId: cart[index].id!,
                                  membersCount: cart[index].membersCount!,
                                  zakatValue: cart[index].zakatValue!,
                                  total: cart[index].zakatValue!,
                                  remain: cart[index].remainValue!,
                                  setSelected: () async {
                                    setState(() {
                                      for (var n in cart) {
                                        n.selected = false;
                                      }
                                      cart[index].selected = true;
                                    });
                                  },
                                  deleteCart: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              title: Text(AppStrings.warning,
                                                  style: AppTypography.kBold18),
                                              content: const Text(
                                                  AppStrings.checkToDelete),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await ZakatCubit.get(
                                                              cartContext)
                                                          .deleteZakat(
                                                              deleteZakatRequest);

                                                      cart.removeWhere(
                                                        (element) =>
                                                            element.id ==
                                                            cartItems[index].id,
                                                      );

                                                      final snackBar = SnackBar(
                                                        duration: Duration(
                                                            milliseconds:
                                                                AppConstants
                                                                    .durationOfSnackBar),
                                                        content: const Text(
                                                            AppStrings
                                                                .successDelete),
                                                      );
                                                      // ignore: use_build_context_synchronously
                                                      ScaffoldMessenger.of(
                                                              cartContext)
                                                          .showSnackBar(
                                                              snackBar);

                                                      await getAllZakat();
                                                      setState(() {});

                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(AppStrings.yes,
                                                        style: AppTypography
                                                            .kLight14)),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(AppStrings.no,
                                                        style: AppTypography
                                                            .kLight14)),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                );
                              }),
                        )
                      : const Center(
                          child: Text(
                            AppStrings.noCarts,
                            style:
                                TextStyle(fontFamily: AppFonts.qabasFontFamily),
                          ),
                        )),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 110.h,
                width: MediaQuery.sizeOf(context).width * 0.75,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius),
                  color: AppColors.cButton,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.total,
                              style: AppTypography.kBold18.copyWith(
                                color: AppColors.cWhite,
                                fontFamily: AppFonts.qabasFontFamily,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  getTotal().toString(),
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cBlack),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'ج.م',
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cWhite),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.remain,
                              style: AppTypography.kBold18.copyWith(
                                color: AppColors.cWhite,
                                fontFamily: AppFonts.qabasFontFamily,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  getRemain().toString(),
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cBlack),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'ج.م',
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cWhite),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        cartItems.isNotEmpty
                            ? await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      title: Text(AppStrings.warning,
                                          style: AppTypography.kBold18),
                                      content:
                                          const Text(AppStrings.deleteAllData),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await deleteAll();
                                              await getAllZakat();
                                              final snackBar = SnackBar(
                                                duration: Duration(
                                                    milliseconds: AppConstants
                                                        .durationOfSnackBar),
                                                content: Text(
                                                    AppStrings.successDelete,
                                                    style:
                                                        AppTypography.kBold16),
                                              );
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(AppStrings.yes,
                                                style: AppTypography.kLight14)),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(AppStrings.no,
                                                style: AppTypography.kLight14)),
                                      ],
                                    ),
                                  );
                                })
                            : null;
                      },
                      child: Container(
                          width: 80.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.w, color: AppColors.cPrimary),
                            borderRadius:
                                BorderRadius.circular(AppConstants.radius),
                            color: AppColors.cWhite,
                            shape: BoxShape.rectangle,
                          ),
                          child: Center(
                            child: Text(
                              AppStrings.deleteAll,
                              style: AppTypography.kLight14.copyWith(
                                fontFamily: AppFonts.qabasFontFamily,
                                color: AppColors.cButton,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07.h,
              ),
            ],
          );
        }),
      ),
    );
  }
}
