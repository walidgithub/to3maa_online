import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class DeleteAllZakatUseCase extends BaseUsecase<void, NoParameters> {
  final BaseRepository baseRepository;

  DeleteAllZakatUseCase(this.baseRepository);

  @override
  Future<Either<Failure, void>> call(NoParameters parameters) async {
    return await baseRepository.deleteAllZakatData();
  }
}
