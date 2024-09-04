import 'package:To3maa/zakat/domain/responses/auth/get_user_data_response.dart';
import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetUserDataUseCase
    extends BaseUsecase<UserDataResponse, NoParameters> {
  final BaseRepository baseRepository;

  GetUserDataUseCase(this.baseRepository);

  @override
  Future<Either<Failure, UserDataResponse>> call(
      NoParameters parameters) async {
    return await baseRepository.getUserData();
  }
}
