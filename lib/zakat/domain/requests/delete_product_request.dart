import 'package:equatable/equatable.dart';

class DeleteProductRequest extends Equatable {
  final int id;

  const DeleteProductRequest({
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