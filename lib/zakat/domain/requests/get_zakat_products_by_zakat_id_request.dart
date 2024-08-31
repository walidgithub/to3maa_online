import 'package:equatable/equatable.dart';

class GetZakatProductsByZatatIdRequest extends Equatable {
  final int zakatId;

  const GetZakatProductsByZatatIdRequest({
    required this.zakatId,
  });


  Map<String, dynamic> toJson() {
    return {
      'zakatId': zakatId,
    };
  }

  @override
  List<Object?> get props => [zakatId];
}