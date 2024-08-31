import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetZakatProductsByKilosUseCase
    extends BaseUsecase<List<ZakatProductsByKilosResponse>, NoParameters> {
  final BaseRepository baseRepository;

  GetZakatProductsByKilosUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<ZakatProductsByKilosResponse>>> call(
      NoParameters parameters) async {
    return await baseRepository.getAllZakatProductsByKilos();
  }
}
