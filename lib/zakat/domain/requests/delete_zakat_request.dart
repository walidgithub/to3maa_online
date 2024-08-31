import 'package:equatable/equatable.dart';

class DeleteZakatRequest extends Equatable {
  final int id;

  const DeleteZakatRequest({
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