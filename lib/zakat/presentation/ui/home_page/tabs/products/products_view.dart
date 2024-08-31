import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/entities/product_image.dart';
import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/products/product_image_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/products/product_view.dart';
import 'package:To3maa/zakat/presentation/ui_components/loading_dialog.dart';
import 'package:To3maa/zakat/presentation/ui_components/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  bool addNew = false;

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescController = TextEditingController();
  final TextEditingController _sa3WeightController = TextEditingController();

  // List<ProductsResponse> products = [];

  int editProductId = 0;
  bool editProduct = false;

  List<ProductImages> productImages = [
    ProductImages(
        imagePath: AppAssets.package,
        activeImage: true,
        imageName: AppStrings.package),
    ProductImages(
        imagePath: AppAssets.dates,
        activeImage: false,
        imageName: AppStrings.dates),
    ProductImages(
        imagePath: AppAssets.lentils,
        activeImage: false,
        imageName: AppStrings.lentils),
    ProductImages(
        imagePath: AppAssets.raisins,
        activeImage: false,
        imageName: AppStrings.raisins),
    ProductImages(
        imagePath: AppAssets.rice,
        activeImage: false,
        imageName: AppStrings.rice),
    ProductImages(
        imagePath: AppAssets.wheat,
        activeImage: false,
        imageName: AppStrings.wheat),
    ProductImages(
        imagePath: AppAssets.lobia,
        activeImage: false,
        imageName: AppStrings.lobia),
    ProductImages(
        imagePath: AppAssets.pasta,
        activeImage: false,
        imageName: AppStrings.pasta),
    ProductImages(
        imagePath: AppAssets.beans,
        activeImage: false,
        imageName: AppStrings.beans),
    ProductImages(
        imagePath: AppAssets.favaBeans,
        activeImage: false,
        imageName: AppStrings.favaBeans),
  ];

  String productImage = '';

  @override
  void initState() {
    productImage = productImages[0].imagePath!;
    getAllProducts();
    super.initState();
  }

  Future<void> getAllProducts() async {
    await ZakatCubit.get(context).getAllProducts();
  }

  void clearValues() {
    _productNameController.text = '';
    _productPriceController.text = '';
    _productDescController.text = '';
    _sa3WeightController.text = '';
    for (var n in productImages) {
      n.activeImage = false;
    }
    productImages[0].activeImage = true;
    productImage = productImages[0].imagePath!;
  }

  @override
  Widget build(BuildContext context) {
    return addNew ? addNewBody() : productsBody();
  }

  Widget productsBody() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.cWhite,
              automaticallyImplyLeading: false,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    iconSize: 30.w,
                    icon: const Icon(Icons.add_box_outlined),
                    onPressed: () {
                      setState(() {
                        addNew = true;
                      });
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              surfaceTintColor: Colors.transparent,
              title: FadeInLeft(
                duration: Duration(milliseconds: AppConstants.animation),
                child: Text(
                  AppStrings.products,
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
              } else if (state.zakatState == RequestState.productsLoaded) {
                // products = state.productsList;
                hideLoading();
              } else if (state.zakatState == RequestState.deleteLoading) {
                showLoading();
              } else if (state.zakatState == RequestState.deleteError) {
                hideLoading();
              } else if (state.zakatState == RequestState.deleteDone) {
                hideLoading();
                final snackBar = SnackBar(
                  duration:
                      Duration(milliseconds: AppConstants.durationOfSnackBar),
                  content: const Text(AppStrings.successDelete),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state.zakatState == RequestState.updateLoading) {
                showLoading();
              } else if (state.zakatState == RequestState.updateError) {
                hideLoading();
              } else if (state.zakatState == RequestState.updateDone) {
                hideLoading();
                final snackBar = SnackBar(
                  duration:
                      Duration(milliseconds: AppConstants.durationOfSnackBar),
                  content: const Text(AppStrings.successUpdate),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }, builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: 10.h,
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
                                      (BuildContext productContext,
                                              int index) =>
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                  itemBuilder:
                                      (BuildContext productContext, int index) {
                                    DeleteProductRequest deleteProductRequest =
                                        (DeleteProductRequest(
                                            id: state.productsList[index].id));

                                    return ProductView(
                                      productName: state
                                          .productsList[index].productName!,
                                      productImage: state
                                          .productsList[index].productImage!,
                                      productPrice: state
                                          .productsList[index].productPrice!,
                                      productDesc: state
                                          .productsList[index].productDesc!,
                                      deleteProduct: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: AlertDialog(
                                                  title: Text(
                                                      AppStrings.warning,
                                                      style: AppTypography
                                                          .kBold18),
                                                  content: const Text(
                                                      AppStrings.checkToDelete),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          await ZakatCubit.get(
                                                                  productContext)
                                                              .deleteProduct(
                                                                  deleteProductRequest);
                                                          await getAllProducts();
                                                          setState(() {});

                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                        child: Text(
                                                            AppStrings.yes,
                                                            style: AppTypography
                                                                .kLight14)),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                        child: Text(
                                                            AppStrings.no,
                                                            style: AppTypography
                                                                .kLight14)),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      editProduct: () {
                                        editProductId =
                                            state.productsList[index].id;
                                        _productPriceController.text = state
                                            .productsList[index].productPrice!;
                                        _productNameController.text = state
                                            .productsList[index].productName!;
                                        _productDescController.text = state
                                            .productsList[index].productDesc!;
                                        _sa3WeightController.text = state
                                            .productsList[index].sa3Weight!
                                            .toString();
                                        productImage = state
                                            .productsList[index].productImage!;

                                        for (var n in productImages) {
                                          n.activeImage = false;
                                        }

                                        int getImageIndex = productImages
                                            .indexWhere((element) =>
                                                element.imagePath ==
                                                state.productsList[index]
                                                    .productImage!);
                                        productImages[getImageIndex]
                                            .activeImage = true;

                                        editProduct = true;
                                        setState(() {
                                          addNew = true;
                                        });
                                      },
                                      editPrice: (String productPrice) async {
                                        UpdateProductRequest
                                            updateProductRequest =
                                            (UpdateProductRequest(
                                                productPrice: productPrice,
                                                productDesc: state
                                                    .productsList[index]
                                                    .productDesc,
                                                productName: state
                                                    .productsList[index]
                                                    .productName,
                                                sa3Weight: state
                                                    .productsList[index]
                                                    .sa3Weight,
                                                productImage: state
                                                    .productsList[index]
                                                    .productImage, productQuantity: 0));

                                        await ZakatCubit.get(productContext)
                                            .updateProduct(
                                                updateProductRequest);

                                        await getAllProducts();
                                        setState(() {});
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
                    height: MediaQuery.sizeOf(context).height * 0.07.h,
                  ),
                ],
              );
            })));
  }

  Widget addNewBody() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.cWhite,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  iconSize: 30.w,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    clearValues();
                    setState(() {
                      editProduct = false;
                      addNew = false;
                    });
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            surfaceTintColor: Colors.transparent,
            title: FadeInLeft(
              duration: Duration(milliseconds: AppConstants.animation),
              child: Text(
                !editProduct ? AppStrings.addNew : AppStrings.editProduct,
                style: AppTypography.kLight20
                    .copyWith(fontFamily: AppFonts.boldFontFamily),
              ),
            ),
          ),
          backgroundColor: AppColors.cWhite,
          body: BlocConsumer<ZakatCubit, ZakatState>(
            listener: (context, state) async {
              if (state.zakatState == RequestState.insertLoading) {
                showLoading();
              } else if (state.zakatState == RequestState.insertError) {
                hideLoading();
              } else if (state.zakatState == RequestState.insertDone) {
                hideLoading();
                final snackBar = SnackBar(
                  duration:
                      Duration(milliseconds: AppConstants.durationOfSnackBar),
                  content: const Text(AppStrings.successAdd),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state.zakatState == RequestState.productsLoading) {
                showLoading();
              } else if (state.zakatState == RequestState.productsError) {
                hideLoading();
              } else if (state.zakatState == RequestState.productsLoaded) {
                hideLoading();
              } else if (state.zakatState == RequestState.updateLoading) {
                showLoading();
              } else if (state.zakatState == RequestState.updateError) {
                hideLoading();
              } else if (state.zakatState == RequestState.updateDone) {
                hideLoading();
                final snackBar = SnackBar(
                  duration:
                      Duration(milliseconds: AppConstants.durationOfSnackBar),
                  content: const Text(AppStrings.successUpdate),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  textFieldWidget(
                      _productNameController,
                      AppStrings.productName,
                      TextInputType.text,
                      (String textVal) {}),
                  SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  textFieldWidget(
                      _productPriceController,
                      AppStrings.productPrice,
                      TextInputType.number,
                      (String textVal) {}),
                  SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  textFieldWidget(_sa3WeightController, AppStrings.sa3Weight,
                      TextInputType.number, (String textVal) {}),
                  SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  textFieldWidget(
                      _productDescController,
                      AppStrings.productDesc,
                      TextInputType.text,
                      (String textVal) {}),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: productImages.length,
                        itemBuilder: (_, index) {
                          return ProductImageView(
                            imagePath: productImages[index].imagePath!,
                            activeImage: productImages[index].activeImage!,
                            imageName: productImages[index].imageName!,
                            makeActive: (String imagePath) {
                              productImage = imagePath;
                              setState(() {
                                for (var n in productImages) {
                                  n.activeImage = false;
                                }
                                productImages[index].activeImage = true;
                                _productNameController.text =
                                    productImages[index].imageName!;
                              });
                            },
                          );
                        }),
                  )),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (editProduct) {
                        if (_productNameController.text.trim() == "" ||
                            double.parse(_productPriceController.text.trim()) <=
                                0 ||
                            double.parse(_sa3WeightController.text.trim()) <=
                                0) {
                          return;
                        }

                        if (double.parse(_productPriceController.text.trim()) <=
                            0) {
                          return;
                        }

                        UpdateProductRequest updateProductRequest =
                            (UpdateProductRequest(
                                productPrice:
                                    _productPriceController.text.trim(),
                                productDesc: _productDescController.text.trim(),
                                productName: _productNameController.text.trim(),
                                sa3Weight: int.parse(
                                    _sa3WeightController.text.trim()),
                                productImage: productImage, productQuantity: 0));

                        await ZakatCubit.get(context)
                            .updateProduct(updateProductRequest);

                        editProductId = 0;
                        _productPriceController.text = '';
                        _productNameController.text = '';
                        _productDescController.text = '';
                        _sa3WeightController.text = '';
                        editProduct = false;
                      } else {
                        if (_productNameController.text.trim() == "" ||
                            double.parse(_productPriceController.text.trim()) <=
                                0 ||
                            double.parse(_sa3WeightController.text.trim()) <=
                                0) {
                          return;
                        }
                        InsertProductRequest insertProductRequest =
                            InsertProductRequest(
                                productDesc: _productDescController.text.trim(),
                                productImage: productImage,
                                productName: _productNameController.text.trim(),
                                sa3Weight:
                                    int.parse(_sa3WeightController.text),
                                productQuantity: 0,
                                productPrice:
                                    _productPriceController.text.trim());

                        await ZakatCubit.get(context)
                            .insertProduct(insertProductRequest);
                      }

                      clearValues();
                      await getAllProducts();

                      setState(() {
                        addNew = false;
                      });
                    },
                    child: Container(
                      height: 50.h,
                      width: MediaQuery.sizeOf(context).width * 0.75,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppConstants.radius),
                        color: AppColors.cButton,
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.save,
                          style: AppTypography.kLight16.copyWith(
                            fontFamily: AppFonts.qabasFontFamily,
                            color: AppColors.cWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.07.h,
                  ),
                ],
              );
            },
          ),
        ));
  }
}
