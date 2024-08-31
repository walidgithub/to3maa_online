import 'package:equatable/equatable.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUsecase<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters parameters);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}
