import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stock_scan_parser/src/core/util/usecase/usecase.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/criteria_entity.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/repositories/stocks_repository.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/usecases/get_stock_scan_usecase.dart';

class MockStocksRepository extends Mock implements StocksRepository {}

void main() {
  MockStocksRepository? repo;
  GetStockScanUsecaseImpl? usecase;

  setUp(() {
    repo = MockStocksRepository();
    usecase = GetStockScanUsecaseImpl(repository: repo!);
  });

  tearDown(() {
    repo = null;
    usecase = null;
  });
  final List<CriteriaEntity> criterias = [
    const CriteriaEntity(type: 'type', text: 'text'),
  ];
  final List<StockscanEntity> stockScans = [
    StockscanEntity(
      id: 1,
      name: 'name',
      tag: 'tag',
      color: 'color',
      criterias: criterias,
    ),
  ];

  test('should get stocks scans from repository', () async {
    ///arrange
    when(repo!.getStockScans()).thenAnswer(
      (_) => Future(
        () => Right(stockScans),
      ),
    );

    ///act
    final actualStockScans = await usecase!(NoParams());

    ///assert
    expect(actualStockScans, Right(stockScans));
    verify(repo!.getStockScans());
  });
}
