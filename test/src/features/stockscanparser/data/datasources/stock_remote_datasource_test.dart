import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_scan_parser/src/core/util/error/exceptions.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/datasources/stock_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:stock_scan_parser/src/features/stockscanparser/data/models/criteria_entity_model.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/models/stocks_scan_entity_model.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/criteria_entity.dart';

import '../../../../../testdata/fixture_reader.dart';
import 'stock_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  StockRemoteDatasourceImpl? stockRemoteDatasourceImpl;
  http.Client? mockClient;

  setUp(() {
    mockClient = MockClient();
    stockRemoteDatasourceImpl = StockRemoteDatasourceImpl(
      httpClient: mockClient!,
    );
  });

  test(
      '''Should perform GET request on a URL with 
  nothing as endpoint and with 'application/json; charset=utf-8' as header''',
      () async {
    ///arrange
    final String url = json.decode(fixtureForUrl)['criteria_data_url'];
    when(
      mockClient!.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        },
      ),
    ).thenAnswer(
      (_) async => http.Response(
        fixture('list_of_stock_scan.json'),
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        },
      ),
    );

    ///act
    await stockRemoteDatasourceImpl!.getStockScans();

    ///assert
    verify(
      mockClient!.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        },
      ),
    );
  });
  test('should throw A [ServerException] when statuscode is not 200', () async {
    ///arrange
    final String url = json.decode(fixtureForUrl)['criteria_data_url'];
    when(
      mockClient!.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        },
      ),
    ).thenAnswer(
      (_) async => http.Response(
        "Something went wrong",
        404,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        },
      ),
    );

    ///act
    final call = stockRemoteDatasourceImpl!.getStockScans;

    ///
    expect(() async => call(), throwsA(const TypeMatcher<ServerException>()));
  });
  group('getStockScans', () {
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
    final List<StockscanEntityModel> stockscanEntityModels = [
      StockscanEntityModel(
        id: 3,
        name: 'Open = High',
        tag: 'Bullish',
        color: 'green',
        criterias: criterias,
      )
    ];

    test('should return list of [StockScanEntityModel] when status code is 200',
        () async {
      ///arrange
      final String url = json.decode(fixtureForUrl)['criteria_data_url'];
      when(
        mockClient!.get(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('list_of_stock_scan.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      ///act
      final result = await stockRemoteDatasourceImpl!.getStockScans();

      ///assert
      expect(result, stockscanEntityModels);
      verify(
        mockClient!.get(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );
    });
  });
}
