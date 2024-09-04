import 'package:To3maa/zakat/domain/responses/auth/forgot_password_response.dart';
import 'package:To3maa/zakat/domain/responses/auth/login_response.dart';
import 'package:To3maa/zakat/domain/responses/auth/register_response.dart';
import 'package:To3maa/zakat/domain/responses/product_data_response.dart';
import 'package:equatable/equatable.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';

import '../../../../domain/responses/auth/get_user_data_response.dart';

class ZakatState extends Equatable {
  final List<ProductsResponse> productsList;
  final List<ZakatResponse> zakatList;
  final List<ZakatProductsByKilosResponse> zakatProductsByKiloList;
  final List<ZakatProductsResponse> zakatProductsByZakatIdList;
  final ProductDataResponse getProductData;
  final UserDataResponse getUserData;
  final RegisterResponse registerData;
  final LoginResponse loginData;
  final ForgotPasswordResponse forgotPasswordData;
  final RequestState zakatState;
  final String zakatMessage;

  const ZakatState({
    this.productsList = const [],
    this.zakatList = const [],
    this.zakatProductsByKiloList = const [],
    this.zakatProductsByZakatIdList = const [],
    this.getProductData = const ProductDataResponse(
        id: 0,
        userId: 0,
        productName: '',
        productPrice: '',
        productDesc: '',
        productImage: '',
        productQuantity: 0,
        sa3Weight: 0,
        createdAt: '',
        updatedAt: ''),
    this.getUserData = const UserDataResponse(id: 0, name: '', email: '', createdAt: '', updatedAt: '', verifyCode: ''),
    this.registerData = const RegisterResponse(message: '',status: false,token: '',user: UserDataResponse(id: 0, name: '', email: '', createdAt: '', updatedAt: '', verifyCode: '')),
    this.loginData = const LoginResponse(message: '',status: false,token: '',user: UserDataResponse(id: 0, name: '', email: '', createdAt: '', updatedAt: '', verifyCode: '')),
    this.forgotPasswordData = const ForgotPasswordResponse(status: false, user: UserDataResponse(id: 0, name: '', email: '', createdAt: '', updatedAt: '', verifyCode: ''), message: ''),
    this.zakatState = RequestState.initialState,
    this.zakatMessage = '',
  });

  ZakatState copyWith({
    List<ProductsResponse>? productsList,
    List<ZakatResponse>? zakatList,
    List<ZakatProductsByKilosResponse>? zakatProductsByKiloList,
    List<ZakatProductsResponse>? zakatProductsByZakatIdList,
    ProductDataResponse? getProductData,
    UserDataResponse? getUserData,
    RegisterResponse? registerData,
    LoginResponse? loginData,
    RequestState? zakatState,
    String? zakatMessage,
    ForgotPasswordResponse? forgotPasswordData,
  }) {
    return ZakatState(
      productsList: productsList ?? this.productsList,
      zakatList: zakatList ?? this.zakatList,
      zakatProductsByKiloList:
          zakatProductsByKiloList ?? this.zakatProductsByKiloList,
      zakatProductsByZakatIdList:
          zakatProductsByZakatIdList ?? this.zakatProductsByZakatIdList,
      getProductData: getProductData ?? this.getProductData,
      getUserData: getUserData ?? this.getUserData,
      registerData: registerData ?? this.registerData,
      loginData: loginData ?? this.loginData,
      forgotPasswordData: forgotPasswordData ?? this.forgotPasswordData,
      zakatState: zakatState ?? this.zakatState,
      zakatMessage: zakatMessage ?? this.zakatMessage,
    );
  }

  @override
  List<Object?> get props => [
        productsList,
        zakatList,
        zakatProductsByKiloList,
        zakatProductsByZakatIdList,
        getProductData,
    getUserData,
    registerData,
    loginData,
    forgotPasswordData,
        zakatState,
        zakatMessage
      ];
}
