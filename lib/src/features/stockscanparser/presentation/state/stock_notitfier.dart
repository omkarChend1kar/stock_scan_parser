///[Marker Interface] abstraction for all the stock notifiers
abstract class StockNotifier {}

abstract class StockScansNotifier extends StockNotifier {
  notifyStockscanEntityList();
}
