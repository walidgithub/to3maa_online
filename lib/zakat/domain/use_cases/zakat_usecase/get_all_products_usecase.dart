import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetAllProductsUseCase
    extends BaseUsecase<List<ProductsResponse>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllProductsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<ProductsResponse>>> call(
      NoParameters parameters) async {
    return await baseRepository.getAllProducts();
  }
}
