import 'package:equatable/equatable.dart';

class CriteriaEntity extends Equatable {
  final String type;
  final String text;
  final Map<String, dynamic>? variable;

  const CriteriaEntity({
    required this.type,
    required this.text,
    this.variable,
  });
  @override
  List<Object?> get props => [type, text, variable];
}
