import 'package:equatable/equatable.dart';

class GetProductDataRequest extends Equatable {
  final int id;

  const GetProductDataRequest({
    required this.id,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  @override
  List<Object?> get props => [id];
}