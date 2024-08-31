import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetAllZakatUseCase
    extends BaseUsecase<List<ZakatResponse>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllZakatUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<ZakatResponse>>> call(
      NoParameters parameters) async {
    return await baseRepository.getAllZakat();
  }
}
