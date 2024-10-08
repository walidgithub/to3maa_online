import 'package:To3maa/zakat/domain/responses/auth/register_response.dart';
import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class RegisterUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  RegisterUseCase(this.baseRepository);

  @override
  Future<Either<Failure, RegisterResponse>> call(parameters) async {
    return await baseRepository.register(parameters);
  }
}