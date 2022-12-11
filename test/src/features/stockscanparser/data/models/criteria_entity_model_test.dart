import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/models/criteria_entity_model.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/criteria_entity.dart';
import '../../../../../testdata/fixture_reader.dart';

void main() {
  const criteriaEntityModel = CriteriaEntityModel(
    type: 'variable',
    text: r'Max of last 5 days close > Max of last 120 days close by $1 %',
    variable: {
      r"$1": {
        "type": "value",
        "values": [2, 1, 3, 5]
      }
    },
  );
  test('should be subclass of [CriteriaEntity]', () async {
    ///assert
    expect(criteriaEntityModel, isA<CriteriaEntity>());
  });

  test('should return a valid model', () {
    ///arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture(
        'criteria.json',
      ),
    );

    ///act
    final result = CriteriaEntityModel.fromJson(jsonMap);

    ///assert
    expect(result, criteriaEntityModel);
  });
}
