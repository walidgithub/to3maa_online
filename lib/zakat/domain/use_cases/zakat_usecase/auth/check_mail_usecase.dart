import 'package:To3maa/zakat/domain/responses/auth/forgot_password_response.dart';
import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class CheckMailUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  CheckMailUseCase(this.baseRepository);

  @override
  Future<Either<Failure, ForgotPasswordResponse>> call(parameters) async {
    return await baseRepository.checkEmail(parameters);
  }
}
