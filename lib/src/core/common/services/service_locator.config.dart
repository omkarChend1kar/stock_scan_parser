// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:stock_scan_parser/src/core/util/module/register_module.dart'
    as _i11;
import 'package:stock_scan_parser/src/core/util/network/network_info.dart'
    as _i5;
import 'package:stock_scan_parser/src/features/stockscanparser/data/datasources/stock_remote_datasource.dart'
    as _i6;
import 'package:stock_scan_parser/src/features/stockscanparser/data/repositories/stock_repository_impl.dart'
    as _i8;
import 'package:stock_scan_parser/src/features/stockscanparser/domain/repositories/stocks_repository.dart'
    as _i7;
import 'package:stock_scan_parser/src/features/stockscanparser/domain/usecases/get_stock_scan_usecase.dart'
    as _i9;
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/state/stockscanslist/stock_scans_notifier_impl.dart'
    as _i10;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.Client>(() => registerModule.httpClient);
    gh.factory<_i4.InternetConnectionChecker>(
        () => registerModule.internetConnectionChecker);
    gh.lazySingleton<_i5.NetworkInfo>(() => _i5.NetworkInfoImpl(
        connectionChecker: gh<_i4.InternetConnectionChecker>()));
    gh.lazySingleton<_i6.StockRemoteDatasource>(
        () => _i6.StockRemoteDatasourceImpl(httpClient: gh<_i3.Client>()));
    gh.lazySingleton<_i7.StocksRepository>(() => _i8.StocksRepositoryImpl(
          remoteDatasource: gh<_i6.StockRemoteDatasource>(),
          networkInfo: gh<_i5.NetworkInfo>(),
        ));
    gh.lazySingleton<_i9.GetStockScanUsecase>(() =>
        _i9.GetStockScanUsecaseImpl(repository: gh<_i7.StocksRepository>()));
    gh.factory<_i10.StockscansNotifierImpl>(
        () => _i10.StockscansNotifierImpl(gh<_i9.GetStockScanUsecase>()));
    return this;
  }
}

class _$RegisterModule extends _i11.RegisterModule {}
