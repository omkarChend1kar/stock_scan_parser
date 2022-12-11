import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/core/common/services/service_locator.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/data/datasources/stock_remote_datasource.dart';

import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/pages/stock_detail_page.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/state/stockscanslist/stock_scans_notifier_impl.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/state/stockscanslist/stock_scans_notifier_provider.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/state/stockscanslist/stock_scans_notifier_state.dart';

class StockPage extends StatelessWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _StocksListWidget(),
      ),
    );
  }
}

class _StocksListWidget extends ConsumerWidget {
  const _StocksListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockscanstate = ref.watch(stockscanNotifierProvider);
    if (stockscanstate is StockscanNotifierCompleteState) {
      final List<StockscanEntity> stockScans = stockscanstate.stockScans;
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          children: List<Column>.generate(stockScans.length, (index) {
            Color tagColor = Colors.green;
            if (stockScans[index].color == 'red') {
              tagColor = Colors.red;
            }
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockDetailPage(
                          stock: stockScans[index],
                          tagColor: tagColor,
                        ),
                      ),
                    );
                  },
                  title: Text(
                    stockScans[index].name,
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.solid,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    stockScans[index].tag,
                    style: TextStyle(
                      color: tagColor,
                      decorationColor: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                ),
                const DottedLine(
                  dashColor: Colors.white,
                  dashLength: 2,
                )
              ],
            );
          }),
        ),
      );
    }
    if (stockscanstate is StockscanNotifierErrorState) {
      final String errorMessage = stockscanstate.failures.message!;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(stockscanNotifierProvider.notifier)
                    .notifyStockscanEntityList();
              },
              child: FutureBuilder<String>(
                future: rootBundle.loadString('assets/lang/app_en.json'),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    final String text = jsonDecode(snapshot.data!)['retry'];
                    return Text(text);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      );
    }
    if (stockscanstate is StockscanNotifierInitialState) {
      return const Center(child: CircularProgressIndicator());
    }
    return const Center(child: CircularProgressIndicator());
  }
}
