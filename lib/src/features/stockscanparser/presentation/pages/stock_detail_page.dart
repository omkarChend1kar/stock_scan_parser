import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stock_scan_parser/src/features/stockscanparser/domain/entities/stock_scan_entity.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/pages/stock_indicator_type_variables_page.dart';
import 'package:stock_scan_parser/src/features/stockscanparser/presentation/pages/stock_value_type_variables_page.dart';

class StockDetailPage extends StatelessWidget {
  const StockDetailPage({
    Key? key,
    required this.stock,
    required this.tagColor,
  }) : super(key: key);
  final StockscanEntity stock;
  final Color tagColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stockHeaderWidget(),
              if (stock.criterias
                  .any((criteriaEntity) => criteriaEntity.type == 'plain_text'))
                ..._plainStockDetailTextWidget()
              else
                ..._variableStockDetailTextWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _stockHeaderWidget() {
    return Container(
      color: const Color(0xff1686B0),
      height: 100,
      child: ListTile(
        title: Text(
          stock.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          stock.tag,
          style: TextStyle(color: tagColor),
        ),
      ),
    );
  }

  _variableStockDetailTextWidget(BuildContext context) {
    return List<Widget>.generate(stock.criterias.length, (stockIndex) {
      final List<String> word = stock.criterias[stockIndex].text.split(" ");

      return Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 20,
        ),
        child: Wrap(
          children: List<Widget>.generate(
            word.length,
            (index) {
              String finalText = '';
              Map<String, dynamic>? variableMap;
              String? variableType;
              if (word[index].contains(r"$")) {
                //TODO : Move hardcoded strings to .arb
                variableMap =
                    stock.criterias[stockIndex].variable![word[index]];
                variableType = variableMap!['type'];
                if (variableType == 'indicator') {
                  finalText = '( ${variableMap['default_value'].toString()} )';
                } else {
                  finalText = '( ${variableMap['values'][0].toString()} )';
                }
              } else {
                finalText = word[index];
              }
              return Consumer(
                builder: (context, ref, __) {
                  return InkWell(
                    onTap: () {
                      if (variableType != null) {
                        if (variableType == 'value') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StockValueTypeVariablesPage(
                                listOfIndicatorValues: variableMap!['values'],
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StockIndicatorTypeVariablesPage(
                                defaultValue: TextEditingController(
                                  text:
                                      variableMap!['default_value'].toString(),
                                ),
                                studyType: variableMap['study_type'],
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: Text(
                        finalText,
                        style: TextStyle(
                          color: word[index].contains(r"$")
                              ? const Color.fromARGB(255, 21, 31, 226)
                              : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    });
  }

  _plainStockDetailTextWidget() {
    return List<Widget>.generate(
      stock.criterias.length,
      (index) {
        return Padding(
          padding:
              const EdgeInsets.only(bottom: 10, right: 10, top: 20, left: 10),
          child: Text(
            stock.criterias[index].text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}
