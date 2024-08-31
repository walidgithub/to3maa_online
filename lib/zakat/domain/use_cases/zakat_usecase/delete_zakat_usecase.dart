import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class DeleteZakatUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  DeleteZakatUseCase(this.baseRepository);

  @override
  Future<Either<Failure, void>> call(parameters) async {
    return await baseRepository.deleteZakatData(parameters);
  }
}
