import 'package:stock_scan_parser/src/features/stockscanparser/data/models/criteria_entity_model.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/criteria_entity.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';

class StockscanEntityModel extends StockscanEntity {
  const StockscanEntityModel({
    required super.id,
    required super.name,
    required super.tag,
    required super.color,
    required super.criterias,
  });

  factory StockscanEntityModel.fromJson(Map<String, dynamic> json) {
    return StockscanEntityModel(
      id: json['id'],
      name: json['name'],
      tag: json['tag'],
      color: json['color'],
      criterias: List<CriteriaEntity>.from(
        (json['criteria'] as List<dynamic>).map(
          (json) => CriteriaEntityModel.fromJson(json),
        ),
      ),
    );
  }
}
