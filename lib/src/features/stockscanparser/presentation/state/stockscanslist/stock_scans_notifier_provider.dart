import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/core/common/services/service_locator.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/state/stockscanslist/stock_scans_notifier_impl.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/state/stockscanslist/stock_scans_notifier_state.dart';

final stockscanNotifierProvider =
    StateNotifierProvider<StockscansNotifierImpl, StockscanNotifierState>(
  (ref) => sl<StockscansNotifierImpl>(),
);
