import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:stock_scan_parser/src/core/util/error/exceptions.dart';
import 'package:stock_scan_parser/src/core/util/error/failures.dart';
import 'package:stock_scan_parser/src/core/util/network/network_info.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/datasources/stock_remote_datasource.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/models/criteria_entity_model.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/models/stocks_scan_entity_model.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/repositories/stock_repository_impl.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/criteria_entity.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';

class MockRemoteDatasource extends Mock implements StockRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  StocksRepositoryImpl? repoImpl;
  MockRemoteDatasource? remoteDatasource;
  MockNetworkInfo? networkInfo;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteDatasource = MockRemoteDatasource();
    repoImpl = StocksRepositoryImpl(
      remoteDatasource: remoteDatasource!,
      networkInfo: networkInfo!,
    );
  });

  tearDown(() {
    networkInfo = null;
    remoteDatasource = null;
    repoImpl = null;
  });

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

  final List<StockscanEntity> stockscanEntitys = stockscanEntityModels;

  group('network is connected', () {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    test('should get remote data when call to remote data source is successful',
        () async {
      ///arrange
      when(remoteDatasource!.getStockScans())
          .thenAnswer((_) async => stockscanEntityModels);

      ///act
      final result = await repoImpl!.getStockScans();

      ///assert
      expect(result, Right(stockscanEntitys));
    });
    test(
        'should get [ServerFailure] when call to remote data is not successful',
        () async {
      ///arrange
      when(remoteDatasource!.getStockScans()).thenThrow(ServerException());

      ///act
      final result = await repoImpl!.getStockScans();

      ///assert
      expect(result, const Left(ServerFailure()));
    });
  });
  group('network is disconnected', () {
    setUp(() {
      ///arrange
      when(networkInfo!.isConnected).thenAnswer((_) async => false);
    });
    test(
        'should return [NetworkFailure] when device is not connected to internet',
        () async {
      ///act
      final result = await repoImpl!.getStockScans();

      ///assert
      expect(result, const Left(NetworkFailure()));
    });
  });
}
