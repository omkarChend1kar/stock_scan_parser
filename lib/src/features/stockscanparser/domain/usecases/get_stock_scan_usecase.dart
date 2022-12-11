import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:stock_scan_parser/src/core/util/error/failures.dart';
import 'package:stock_scan_parser/src/core/util/usecase/usecase.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/repositories/stocks_repository.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/usecases/stock_scan_parser_usecase.dart';

///[Marker Interface] to get the stock scans
abstract class GetStockScanUsecase extends StockScanParserUsecase
    implements UseCase<List<StockscanEntity>?, NoParams> {}

@LazySingleton(as: GetStockScanUsecase)
class GetStockScanUsecaseImpl extends GetStockScanUsecase {
  final StocksRepository repository;
  GetStockScanUsecaseImpl({required this.repository});

  @override
  Future<Either<Failures, List<StockscanEntity>?>>? call(NoParams params) {
    return repository.getStockScans();
  }
}
