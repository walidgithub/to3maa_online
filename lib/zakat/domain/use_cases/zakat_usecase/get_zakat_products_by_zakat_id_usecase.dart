import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetZakatProductsByZakatIdUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  GetZakatProductsByZakatIdUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<ZakatProductsResponse>>> call(parameters) async {
    return await baseRepository.getZakatProductsByZakatId(parameters);
  }
}
