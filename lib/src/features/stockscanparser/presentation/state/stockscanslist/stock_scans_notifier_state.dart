import 'package:equatable/equatable.dart';
import 'package:stock_scan_parser/src/core/util/error/failures.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';

abstract class StockscanNotifierState extends Equatable {}

class StockscanNotifierInitialState extends StockscanNotifierState {
  @override
  List<Object?> get props => [];
}

class StockscanNotifierCompleteState extends StockscanNotifierState {
  final List<StockscanEntity> stockScans;

  StockscanNotifierCompleteState({required this.stockScans});
  @override
  List<Object?> get props => [stockScans];
}

class StockscanNotifierErrorState extends StockscanNotifierState {
  final Failures failures;

  StockscanNotifierErrorState({required this.failures});
  @override
  List<Object?> get props => [failures];
}
