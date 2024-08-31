import 'package:To3maa/zakat/data/data_source/zakat_datasource.dart';
import 'package:To3maa/zakat/data/repository/zakat_repository.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/requests/get_product_data_request.dart';
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
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/auth/logout_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/update_product_usecase.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/network_info.dart';
import '../../../core/preferences/app_pref.dart';
import '../../domain/use_cases/zakat_usecase/auth/login_usecase.dart';
import '../../domain/use_cases/zakat_usecase/auth/register_usecase.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // app prefs instance
    final sharedPrefs = await SharedPreferences.getInstance();

    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

    // Network Info
    sl.registerLazySingleton<NetworkInfo>(
            () => NetworkInfoImpl(InternetConnectionChecker()));

    // Cubit
    sl.registerFactory(() => ZakatCubit(sl(), sl(), sl(), sl(), sl(), sl(),
        sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

    // Use Cases
    sl.registerLazySingleton<LoginUseCase>(
            () => LoginUseCase(sl()));

    sl.registerLazySingleton<RegisterUseCase>(
            () => RegisterUseCase(sl()));

    sl.registerLazySingleton<LogoutUseCase>(
            () => LogoutUseCase(sl()));

    sl.registerLazySingleton<DeleteProductUseCase>(
        () => DeleteProductUseCase(sl()));

    sl.registerLazySingleton<DeleteZakatUseCase>(
        () => DeleteZakatUseCase(sl()));

    sl.registerLazySingleton<DeleteAllZakatUseCase>(
        () => DeleteAllZakatUseCase(sl()));

    sl.registerLazySingleton<GetAllProductsUseCase>(
        () => GetAllProductsUseCase(sl()));

    sl.registerLazySingleton<GetAllZakatUseCase>(
        () => GetAllZakatUseCase(sl()));

    sl.registerLazySingleton<GetZakatProductsByKilosUseCase>(
        () => GetZakatProductsByKilosUseCase(sl()));

    sl.registerLazySingleton<GetZakatProductsByZakatIdUseCase>(
        () => GetZakatProductsByZakatIdUseCase(sl()));

    sl.registerLazySingleton<GetProductDataUseCase>(
            () => GetProductDataUseCase(sl()));

    sl.registerLazySingleton<InsertProductUseCase>(
        () => InsertProductUseCase(sl()));

    sl.registerLazySingleton<InsertZakatUseCase>(
        () => InsertZakatUseCase(sl()));

    sl.registerLazySingleton<UpdateProductUseCase>(
        () => UpdateProductUseCase(sl()));

    // Repositories
    sl.registerLazySingleton<BaseRepository>(() => ZakatRepository(sl()));

    // Local DataSource
    sl.registerLazySingleton<BaseDataSource>(() => ZakatDataSource(sl()));
  }
}
