import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import 'package:stock_scan_parser/src/core/util/error/failures.dart';
import 'package:stock_scan_parser/src/core/util/usecase/usecase.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/usecases/get_stock_scan_usecase.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/state/stock_notitfier.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/state/stockscanslist/stock_scans_notifier_state.dart';

@injectable
class StockscansNotifierImpl extends StateNotifier<StockscanNotifierState>
    implements StockScansNotifier {
  StockscansNotifierImpl(
    this.getStockScanUsecase,
  ) : super(StockscanNotifierInitialState()) {
    ///
    notifyStockscanEntityList();
  }

  final GetStockScanUsecase getStockScanUsecase;

  @override
  notifyStockscanEntityList() async {
    final asyncEither = getStockScanUsecase(NoParams());
    final Future<Map<String, dynamic>> asyncMsgMap =
        rootBundle.loadString('assets/lang/app_en.json').then(
      (source) {
        return jsonDecode(source);
      },
    );
    if (asyncEither == null) {
      state = StockscanNotifierErrorState(
        failures: MiscellaneousFailure(
          message:
              await (asyncMsgMap as Map<String, dynamic>)['unknown_error_msg'],
        ),
      );
      return;
    }
    asyncEither.then((either) {
      either.fold(
        (l) {
          state = StockscanNotifierErrorState(failures: l);
        },
        (r) {
          if (r == null) {
            state = StockscanNotifierErrorState(
              failures: MiscellaneousFailure(
                message:
                    (asyncMsgMap as Map<String, dynamic>)['unknown_error_msg'],
              ),
            );
            return;
          }
          state = StockscanNotifierCompleteState(stockScans: r);
        },
      );
    });
  }
}
