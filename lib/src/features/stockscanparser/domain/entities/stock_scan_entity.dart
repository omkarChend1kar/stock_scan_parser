import 'package:equatable/equatable.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/criteria_entity.dart';

class StockscanEntity extends Equatable {
  final int id;
  final String name;
  final String tag;
  final String color;
  final List<CriteriaEntity> criterias;

  const StockscanEntity({
    required this.id,
    required this.name,
    required this.tag,
    required this.color,
    required this.criterias,
  });

  @override
  List<Object?> get props => [id, name, tag, color, criterias];
}
