import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stock_scan_parser/src/core/util/error/exceptions.dart';
import 'package:stock_scan_parser/src/core/util/network/network_info.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/datasources/stock_remote_datasource.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';
import 'package:stock_scan_parser/src/core/util/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/domain/repositories/stocks_repository.dart';

@LazySingleton(as: StocksRepository)
class StocksRepositoryImpl implements StocksRepository {
  final StockRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  StocksRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failures, List<StockscanEntity>?>>? getStockScans() async {
    final Future<Map<String, dynamic>> asyncMsgMap =
        rootBundle.loadString('assets/lang/app_en.json').then(
      (source) {
        return jsonDecode(source);
      },
    );
    final bool isDeviceOnline = await networkInfo.isConnected!;
    if (isDeviceOnline) {
      try {
        return Right(await remoteDatasource.getStockScans());
      } on ServerException {
        return asyncMsgMap.then(
          (jsonMap) => Left(
            ServerFailure(
              message: jsonMap['unknown_error_msg'],
            ),
          ),
        );
      }
    } else {
      return asyncMsgMap.then(
        (jsonMap) => Left(
          NetworkFailure(
            message: jsonMap['no_internet_connection'],
          ),
        ),
      );
    }
  }
}
