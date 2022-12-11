import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/criteria_entity.dart';

class CriteriaEntityModel extends CriteriaEntity {
  const CriteriaEntityModel(
      {required super.type, required super.text, super.variable});

  factory CriteriaEntityModel.fromJson(Map<String, dynamic> json) {
    return CriteriaEntityModel(
      type: json['type'],
      text: json['text'].toString(),
      variable: json['variable']
    );
  }
}
