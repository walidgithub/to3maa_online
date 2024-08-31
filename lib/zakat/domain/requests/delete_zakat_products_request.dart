import 'package:equatable/equatable.dart';

class DeleteZakatProductsRequest extends Equatable {
  final int id;

  const DeleteZakatProductsRequest({
    required this.id,
  });


  Map<String, dynamic> toJson() {
    return {
      'zakatId': id,
    };
  }

  @override
  List<Object?> get props => [id];
}