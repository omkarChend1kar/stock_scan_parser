import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:stock_scan_parser/src/features/stockscanparser/data/models/criteria_entity_model.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/models/stocks_scan_entity_model.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/criteria_entity.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';

import '../../../../../testdata/fixture_reader.dart';

void main() {
  final List<CriteriaEntity> criterias = [
    const CriteriaEntityModel(
      type: 'variable',
      text: r'Today’s open < yesterday’s low by $1 %',
      variable: {
        r"$1": {
          "type": "value",
          "values": [-3, -1, -2, -5, -10]
        }
      },
    ),
  ];
  final stockscanEntityModel = StockscanEntityModel(
    id: 3,
    name: 'Open = High',
    tag: 'Bullish',
    color: 'green',
    criterias: criterias,
  );
  test(
    'should be subclass of [StockscanEntity]',
    () async {
      ///assert
      expect(stockscanEntityModel, isA<StockscanEntity>());
    },
  );
  test('should get a valid model', () {
    ///arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture(
        'stockscan.json',
      ),
    );

    ///act
    final result = StockscanEntityModel.fromJson(jsonMap);

    ///assert
    expect(result, stockscanEntityModel);
  });
}
