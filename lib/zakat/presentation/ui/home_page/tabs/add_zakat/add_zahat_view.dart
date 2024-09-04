import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/entities/cart_items.dart';
import 'package:To3maa/zakat/domain/entities/suggested_items.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/add_zakat/add_product_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/add_zakat/suggested_view.dart';
import 'package:To3maa/zakat/presentation/ui_components/loading_dialog.dart';
import 'package:To3maa/zakat/presentation/ui_components/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddZakatView extends StatefulWidget {
  const AddZakatView({super.key});

  @override
  State<AddZakatView> createState() => _AddZakatViewState();
}

class _AddZakatViewState extends State<AddZakatView> {
  final TextEditingController _membersCountController = TextEditingController();
  final TextEditingController _zakatValueController = TextEditingController();

  @override
  void initState() {
    getAllZakat();
    clearData();
    super.initState();
  }

  Future<void> resetQuantity(var products) async {
    for (var x in products) {
      UpdateProductRequest
      updateProductRequest =
      (UpdateProductRequest(
          productQuantity: 0,productDesc: x.productDesc,productImage: x.productImage,productName: x.productName,productPrice: x.productPrice,sa3Weight: x.sa3Weight));
      await ZakatCubit.get(context).updateProduct(updateProductRequest);
    }
  }

  double remain = 0.0;
  double allValue = 0.0;
  double allProductsValue = 0.0;

  void clearData() {
    _membersCountController.text = '';
    _zakatValueController.text = '';
    remain = 0;
    allValue = 0;
    allProductsValue = 0;
    suggestedItems.clear();
    suggested = false;
    getAllProducts();
  }

  bool suggested = false;

  List<SuggestedItems> suggestedItems = [];

  Future<void> getAllProducts() async {
    await ZakatCubit.get(context).getAllProducts();
  }

  Future<void> getAllZakat() async {
    await ZakatCubit.get(context).getAllZakat();
  }

  double calcRemain(var products) {
    double allProductsValue = 0.0;
    for (var x in products) {
      double productTotal =
          double.parse(x.productPrice!) * (x.productQuantity ?? 0);
      allProductsValue = allProductsValue + productTotal;
    }
    return allProductsValue;
  }

  void getSuggested(int membersCount, int zakatValue, var products) {
    if (membersCount > 0 && zakatValue > 0) {
      double valPerMember = zakatValue / membersCount;
      suggestedItems.clear();
      for (var x in products) {
        if (valPerMember >= double.parse(x.productPrice!)) {
          suggestedItems.add(SuggestedItems(
              imageId: x.id,
              imagePath: x.productImage,
              imageDesc: x.productDesc,
              selected: false,
              imagePrice: x.productPrice,
              imageSa3: x.sa3Weight,
              imageName: x.productName));
        }
      }
      setState(() {
        suggested = true;
      });
    } else {
      setState(() {
        suggested = false;
      });
    }
    if (suggestedItems.isEmpty) {
      setState(() {
        suggested = false;
      });
    }
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
                AppStrings.addZakat,
                style: AppTypography.kLight20
                    .copyWith(fontFamily: AppFonts.boldFontFamily),
              ),
            ),
          ),
          backgroundColor: AppColors.cWhite,
          body: BlocConsumer<ZakatCubit, ZakatState>(
              listener: (context, state) async {
            if (state.zakatState == RequestState.productsLoading) {
              showLoading();
            } else if (state.zakatState == RequestState.productsError) {
              hideLoading();
              final snackBar = SnackBar(
                duration:
                Duration(milliseconds: AppConstants.durationOfSnackBar),
                content: Text(state.zakatMessage),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state.zakatState == RequestState.productsLoaded) {
              remain = allValue - calcRemain(state.productsList);
              hideLoading();
            } else if (state.zakatState == RequestState.insertLoading) {
              showLoading();
            } else if (state.zakatState == RequestState.insertError) {
              hideLoading();
              final snackBar = SnackBar(
                duration:
                Duration(milliseconds: AppConstants.durationOfSnackBar),
                content: Text(state.zakatMessage),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state.zakatState == RequestState.insertDone) {
              hideLoading();
              getAllZakat();
            } else if (state.zakatState == RequestState.zakatLoading) {
              showLoading();
            } else if (state.zakatState == RequestState.zakatError) {
              hideLoading();
              final snackBar = SnackBar(
                duration:
                Duration(milliseconds: AppConstants.durationOfSnackBar),
                content: Text(state.zakatMessage),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state.zakatState == RequestState.zakatLoaded) {
              hideLoading();
              cartItems = state.zakatList;
            }
          }, builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                textFieldWidget(
                    _membersCountController,
                    AppStrings.membersCount,
                    TextInputType.number, (String textVal) {
                  getSuggested(
                      int.parse(_membersCountController.text),
                      int.parse(_zakatValueController.text),
                      state.productsList);
                }),
                SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                textFieldWidget(_zakatValueController, AppStrings.zakatValue,
                    TextInputType.number, (String textVal) {
                  setState(() {
                    allValue = double.parse(textVal);
                    remain = allValue - calcRemain(state.productsList);
                  });
                  getSuggested(
                      int.parse(_membersCountController.text),
                      int.parse(_zakatValueController.text),
                      state.productsList);
                }),
                suggested
                    ? SizedBox(
                        height: 5.h,
                      )
                    : Container(),
                suggested
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppStrings.suggested,
                            style:
                                TextStyle(fontFamily: AppFonts.qabasFontFamily),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.75,
                            height: 120.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.w, color: AppColors.cPrimary),
                              borderRadius:
                                  BorderRadius.circular(AppConstants.radius),
                            ),
                            child: ListView.separated(
                                itemCount: suggestedItems.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                          width: 10.h,
                                        ),
                                itemBuilder: (BuildContext context, int index) {
                                  return SuggestedView(
                                    imagePath: suggestedItems[index].imagePath!,
                                    imageName: suggestedItems[index].imageName!,
                                    imageDesc: suggestedItems[index].imageDesc!,
                                    selected: suggestedItems[index].selected!,
                                    id: suggestedItems[index].imageId!,
                                    addSuggested: (int id) async {
                                      setState(() {
                                        for (var n in suggestedItems) {
                                          n.selected = false;
                                        }
                                        suggestedItems[index].selected = true;
                                      });

                                      await resetQuantity(state.productsList);

                                      UpdateProductRequest
                                          updateProductRequest =
                                          (UpdateProductRequest(
                                              productQuantity: int.parse(
                                                  _membersCountController
                                                      .text),productDesc: suggestedItems[index].imageDesc!,productImage: suggestedItems[index].imagePath!,productName: suggestedItems[index].imageName!,productPrice: suggestedItems[index].imagePrice!,sa3Weight: int.parse(suggestedItems[index].imageSa3.toString())));

                                      await ZakatCubit.get(context)
                                          .updateProduct(updateProductRequest);

                                      await getAllProducts();
                                    },
                                  );
                                }),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                    child: state.productsList.isNotEmpty
                        ? SingleChildScrollView(
                            child: ListView.separated(
                                itemCount: state.productsList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                itemBuilder: (BuildContext context, int index) {
                                  return AddProductView(
                                    productName:
                                        state.productsList[index].productName,
                                    productImage:
                                        state.productsList[index].productImage,
                                    productPrice:
                                        state.productsList[index].productPrice,
                                    productDesc:
                                        state.productsList[index].productDesc,
                                    productQuantity: state
                                        .productsList[index].productQuantity,
                                    allValue: allValue,
                                    productsList: state.productsList,
                                    increaseQunatity: (int quantity) async {
                                      UpdateProductRequest
                                      updateProductRequest =
                                      (UpdateProductRequest(
                                          productQuantity: quantity,productDesc: state.productsList[index].productDesc,productImage: state.productsList[index].productImage,productName: state.productsList[index].productName,productPrice: state.productsList[index].productPrice,sa3Weight: state.productsList[index].sa3Weight));


                                      await ZakatCubit.get(context)
                                          .updateProduct(
                                              updateProductRequest);

                                      setState(() {
                                        state.productsList[index]
                                            .productQuantity = quantity;
                                        remain = allValue -
                                            calcRemain(state.productsList);
                                      });
                                    },
                                    decreaseQunatity: (int quantity) async {
                                      UpdateProductRequest
                                      updateProductRequest =
                                      (UpdateProductRequest(
                                          productQuantity: quantity,productDesc: state.productsList[index].productDesc,productImage: state.productsList[index].productImage,productName: state.productsList[index].productName,productPrice: state.productsList[index].productPrice,sa3Weight: state.productsList[index].sa3Weight));

                                      await ZakatCubit.get(context)
                                          .updateProduct(
                                              updateProductRequest);

                                      setState(() {
                                        state.productsList[index]
                                            .productQuantity = quantity;
                                        remain = allValue -
                                            calcRemain(state.productsList);
                                      });
                                    },
                                  );
                                }),
                          )
                        : const Center(
                            child: Text(
                              AppStrings.noProducts,
                              style: TextStyle(
                                  fontFamily: AppFonts.qabasFontFamily),
                            ),
                          )),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 110.h,
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.radius),
                    color: AppColors.cButton,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    allValue.toString(),
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
                                    remain.toString(),
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
                          GestureDetector(
                            onTap: () async {
                              if (remain >= allValue) {
                                return;
                              }

                              if (remain.isNegative) {
                                return;
                              }

                              if (double.parse(_membersCountController.text
                                          .trim()) <=
                                      0 ||
                                  double.parse(
                                          _zakatValueController.text.trim()) <=
                                      0) {
                                return;
                              }

                              List<InsertZakatProductsRequest>
                                  listOfZakatProducts = [];

                              for (var x in state.productsList) {
                                InsertZakatProductsRequest
                                    insertZakatProductsRequest =
                                    InsertZakatProductsRequest(
                                        productDesc: x.productDesc,
                                        productImage: x.productImage,
                                        productName: x.productName,
                                        productPrice: x.productPrice,
                                        productQuantity: x.productQuantity,
                                        sa3Weight: x.sa3Weight);

                                listOfZakatProducts
                                    .add(insertZakatProductsRequest);
                                x.productQuantity = 0;
                              }

                              InsertZakatRequest insertZakatRequest =
                                  InsertZakatRequest(
                                      membersCount: int.parse(
                                          _membersCountController.text.trim()),
                                      zakatValue:
                                          _zakatValueController.text.trim(),
                                      remainValue: remain.toString(),
                                      zakatProducts: listOfZakatProducts);

                              await ZakatCubit.get(context)
                                  .insertZakat(insertZakatRequest);

                              final snackBar = SnackBar(
                                duration: Duration(
                                    milliseconds:
                                        AppConstants.durationOfSnackBar),
                                content: const Text(AppStrings.successAdd),
                              );
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              setState(() {
                                clearData();
                                resetQuantity(state.productsList);
                              });
                            },
                            child: Container(
                                width: 70.w,
                                height: 50.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.w, color: AppColors.cPrimary),
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.radius),
                                  color: AppColors.cWhite,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Center(
                                  child: Text(
                                    AppStrings.save,
                                    style: AppTypography.kLight14.copyWith(
                                      fontFamily: AppFonts.qabasFontFamily,
                                      color: AppColors.cButton,
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.07.h,
                ),
              ],
            );
          })),
    );
  }
}
