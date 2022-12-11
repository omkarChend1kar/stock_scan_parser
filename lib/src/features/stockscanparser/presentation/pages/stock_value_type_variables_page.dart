import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class StockValueTypeVariablesPage extends StatelessWidget {
  const StockValueTypeVariablesPage({
    Key? key,
    required this.listOfIndicatorValues,
  }) : super(key: key);
  final List<dynamic> listOfIndicatorValues;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _stockValueTypeVariablesWidget(),
      ),
    );
  }

  Widget _stockValueTypeVariablesWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 30,
      ),
      child: Column(
        children: List<Widget>.generate(
          listOfIndicatorValues.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 25,
                  bottom: 25,
                ),
                child: Text(
                  listOfIndicatorValues[index].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const DottedLine(
                dashColor: Colors.white,
                dashLength: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
