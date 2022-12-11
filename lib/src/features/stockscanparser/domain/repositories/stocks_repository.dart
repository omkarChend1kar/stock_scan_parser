import 'package:dartz/dartz.dart';
import 'package:stock_scan_parser/src/core/util/error/failures.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';

///[Marker Interface] abstraction of stocks repository
abstract class StocksRepository {
  ///Get the stock scans
  Future<Either<Failures, List<StockscanEntity>?>>? getStockScans();
}
