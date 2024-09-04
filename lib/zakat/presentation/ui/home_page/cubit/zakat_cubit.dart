import 'dart:async';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/get_product_data_request.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/domain/responses/auth/login_response.dart';
import 'package:To3maa/zakat/domain/responses/auth/register_response.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_all_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_product_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_products_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_product_data_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_zakat_products_by_kilos_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_zakat_products_by_zakat_id_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_product_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/update_product_usecase.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/requests/auth/login_request.dart';
import '../../../../domain/requests/auth/register_request.dart';
import '../../../../domain/requests/auth/forgot_password_request.dart';
import '../../../../domain/responses/auth/forgot_password_response.dart';
import '../../../../domain/responses/auth/get_user_data_response.dart';
import '../../../../domain/responses/product_data_response.dart';
import '../../../../domain/use_cases/zakat_usecase/auth/check_mail_usecase.dart';
import '../../../../domain/use_cases/zakat_usecase/auth/get_user_data_usecase.dart';
import '../../../../domain/use_cases/zakat_usecase/auth/login_usecase.dart';
import '../../../../domain/use_cases/zakat_usecase/auth/logout_usecase.dart';
import '../../../../domain/use_cases/zakat_usecase/auth/register_usecase.dart';
import '../../../../domain/use_cases/zakat_usecase/auth/reset_password_usecase.dart';

class ZakatCubit extends Cubit<ZakatState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final DeleteZakatUseCase deleteZakatUseCase;
  final DeleteAllZakatUseCase deleteAllZakatUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductDataUseCase getProductDataUseCase;
  final GetAllZakatUseCase getAllZakatUseCase;
  final GetZakatProductsByKilosUseCase getZakatProductsByKilosUseCase;
  final GetZakatProductsByZakatIdUseCase getZakatProductsByZakatIdUseCase;
  final InsertProductUseCase insertProductUseCase;
  final InsertZakatUseCase insertZakatUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final CheckMailUseCase checkMailUseCase;
  final ResetPassUseCase resetPassUseCase;

  ZakatCubit(
    this.loginUseCase,
    this.registerUseCase,
    this.logoutUseCase,
    this.deleteZakatUseCase,
    this.deleteAllZakatUseCase,
    this.deleteProductUseCase,
    this.getUserDataUseCase,
    this.getAllProductsUseCase,
    this.getAllZakatUseCase,
    this.getZakatProductsByKilosUseCase,
    this.getZakatProductsByZakatIdUseCase,
    this.getProductDataUseCase,
    this.insertProductUseCase,
    this.insertZakatUseCase,
    this.updateProductUseCase,
    this.checkMailUseCase,
    this.resetPassUseCase,
  ) : super(const ZakatState());

  static ZakatCubit get(context) => BlocProvider.of(context);

  // auth ----------------------------------------------------------
  FutureOr<void> register(RegisterRequest registerRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.registerLoading,
        zakatMessage: '',
        registerData: const RegisterResponse(
            message: '',
            status: false,
            token: '',
            user: UserDataResponse(
                id: 0,
                name: '',
                email: '',
                createdAt: '',
                updatedAt: '',
                verifyCode: ''))));

    final result = await registerUseCase(registerRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.registerError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              registerData: r,
              zakatState: RequestState.registerDone,
            )));
  }

  FutureOr<void> login(LoginRequest loginRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.loginLoading,
        zakatMessage: '',
        loginData: const LoginResponse(
            message: '',
            status: false,
            token: '',
            user: UserDataResponse(
                id: 0,
                name: '',
                email: '',
                createdAt: '',
                updatedAt: '',
                verifyCode: ''))));

    final result = await loginUseCase(loginRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.loginError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              loginData: r,
              zakatState: RequestState.loginDone,
            )));
  }

  FutureOr<void> logout() async {
    emit(state.copyWith(
        zakatState: RequestState.logoutLoading, zakatMessage: ''));

    final result = await logoutUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.logoutError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatState: RequestState.logoutDone,
            )));
  }

  // insert data ------------------------------------------------------
  FutureOr<void> insertZakat(InsertZakatRequest insertZakatRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.insertLoading, zakatMessage: ''));

    final result = await insertZakatUseCase(insertZakatRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.insertError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatState: RequestState.insertDone,
            )));
  }

  FutureOr<void> insertProduct(
      InsertProductRequest insertProductRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.insertLoading, zakatMessage: ''));

    final result = await insertProductUseCase(insertProductRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.insertError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatState: RequestState.insertDone,
            )));
  }

  // update data ------------------------------------------------------
  FutureOr<void> updateProduct(
      UpdateProductRequest updateProductRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.updateLoading, zakatMessage: ''));

    final result = await updateProductUseCase(updateProductRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.updateError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatState: RequestState.updateDone,
            )));
  }

  FutureOr<void> checkMail(ForgotPassRequest forgotPassRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.updateLoading,
        zakatMessage: '',
        forgotPasswordData: const ForgotPasswordResponse(
            status: false,
            user: UserDataResponse(
                id: 0,
                name: '',
                email: '',
                createdAt: '',
                updatedAt: '',
                verifyCode: ''),
            message: '')));

    final result = await checkMailUseCase(forgotPassRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.updateError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              forgotPasswordData: r,
              zakatState: RequestState.updateDone,
            )));
  }

  FutureOr<void> resetPass(ForgotPassRequest forgotPassRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.updateLoading, zakatMessage: ''));

    final result = await resetPassUseCase(forgotPassRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.updateError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatState: RequestState.updateDone,
            )));
  }

  // delete data ------------------------------------------------------
  FutureOr<void> deleteZakat(DeleteZakatRequest deleteZakatRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading, zakatMessage: ''));

    final result = await deleteZakatUseCase(deleteZakatRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatState: RequestState.deleteDone,
            )));
  }

  FutureOr<void> deleteAllZakat() async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading, zakatMessage: ''));

    final result = await deleteAllZakatUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatState: RequestState.deleteDone,
            )));
  }

  FutureOr<void> deleteProduct(
      DeleteProductRequest deleteProductRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading, zakatMessage: ''));

    final result = await deleteProductUseCase(deleteProductRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatState: RequestState.deleteDone,
            )));
  }

  // get data ---------------------------------------------------------
  FutureOr<void> getAllZakat() async {
    emit(state.copyWith(
        zakatState: RequestState.zakatLoading,
        zakatMessage: '',
        zakatList: []));

    final result = await getAllZakatUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.zakatError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatList: r,
              zakatState: RequestState.zakatLoaded,
            )));
  }

  FutureOr<void> getAllProducts() async {
    emit(state.copyWith(
        zakatState: RequestState.productsLoading,
        zakatMessage: '',
        productsList: []));

    final result = await getAllProductsUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.productsError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              productsList: r,
              zakatState: RequestState.productsLoaded,
            )));
  }

  FutureOr<void> getZakatProductsByKilos() async {
    emit(state.copyWith(
        zakatState: RequestState.getZakatProductsByKilosLoading,
        zakatMessage: '',
        zakatProductsByKiloList: []));

    final result = await getZakatProductsByKilosUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.getZakatProductsByKilosError,
            zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatProductsByKiloList: r,
              zakatState: RequestState.getZakatProductsByKilosLoaded,
            )));
  }

  FutureOr<void> getZakatProductsByZakatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.getZakatProductsByZakatIdLoading,
        zakatMessage: '',
        zakatProductsByZakatIdList: []));

    final result = await getZakatProductsByZakatIdUseCase(
        getZakatProductsByZatatIdRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.getZakatProductsByZakatIdError,
            zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatProductsByZakatIdList: r,
              zakatState: RequestState.getZakatProductsByZakatIdLoaded,
            )));
  }

  FutureOr<void> getProductData(
      GetProductDataRequest getProductDataRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.getProductDataLoading,
        zakatMessage: '',
        getProductData: const ProductDataResponse(
            id: 0,
            userId: 0,
            productName: '',
            productPrice: '',
            productDesc: '',
            productImage: '',
            productQuantity: 0,
            sa3Weight: 0,
            createdAt: '',
            updatedAt: '')));

    final result = await getProductDataUseCase(getProductDataRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.getProductDataError,
            zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              getProductData: r,
              zakatState: RequestState.getProductDataLoaded,
            )));
  }

  FutureOr<void> getUserData() async {
    emit(state.copyWith(
        zakatState: RequestState.getUserDataLoading,
        zakatMessage: '',
        getUserData: const UserDataResponse(
            id: 0,
            name: '',
            email: '',
            createdAt: '',
            updatedAt: '',
            verifyCode: '')));

    final result = await getUserDataUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.getUserDataError,
            zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              getUserData: r,
              zakatState: RequestState.getUserDataLoaded,
            )));
  }
}
