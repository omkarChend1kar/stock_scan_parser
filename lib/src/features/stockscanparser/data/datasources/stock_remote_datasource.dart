import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:flutter/services.dart';

import 'package:stock_scan_parser/src/core/util/error/exceptions.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/models/stocks_scan_entity_model.dart';

abstract class StockRemoteDatasource {
  ///Calls for the endpoint http://coding-assignment.bombayrunning.com/data.json
  ///
  ///Throws a [ServerException] when status code is not 200
  Future<List<StockscanEntityModel>>? getStockScans();
}

@LazySingleton(as: StockRemoteDatasource)
class StockRemoteDatasourceImpl implements StockRemoteDatasource {
  final http.Client httpClient;

  StockRemoteDatasourceImpl({
    required this.httpClient,
  });
  @override
  Future<List<StockscanEntityModel>>? getStockScans() {
    final Future<String> asyncUrl =
        rootBundle.loadString('assets/api/config.json').then(
      (source) {
        return jsonDecode(source)['criteria_data_url'];
      },
    );

    ///
    final Future<http.Response> asyncResponse = asyncUrl.then((url) {
      return httpClient.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        },
      );
    });

    ///
    return asyncResponse.then((response) {
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        final Iterable rawData = jsonData;
        return List<StockscanEntityModel>.from(
          rawData.map(
            (json) => StockscanEntityModel.fromJson(json),
          ),
        );
      } else {
        throw ServerException();
      }
    });
  }
}
