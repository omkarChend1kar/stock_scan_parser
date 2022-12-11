import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockIndicatorTypeVariablesPage extends StatelessWidget {
  const StockIndicatorTypeVariablesPage(
      {Key? key, required this.studyType, required this.defaultValue})
      : super(key: key);
  final String studyType;
  final TextEditingController defaultValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _stockIndicatorTypeVariablesWidget(),
      ),
    );
  }

  Widget _stockIndicatorTypeVariablesWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              studyType.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              //TODO : Move to .arb file
              'Set Parameters',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 200,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 30,
                    child: Center(
                      child: Text(
                        'Period',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: TextField(
                      controller: defaultValue,
                      selectionControls: CupertinoTextSelectionControls(),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
