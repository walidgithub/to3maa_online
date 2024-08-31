import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

import '../../responses/product_data_response.dart';

class GetProductDataUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  GetProductDataUseCase(this.baseRepository);

  @override
  Future<Either<Failure, ProductDataResponse>> call(parameters) async {
    return await baseRepository.getProductData(parameters);
  }
}