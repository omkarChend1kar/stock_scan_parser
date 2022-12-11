import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_scan_parser/src/app.dart';
import 'package:stock_scan_parser/src/core/common/services/service_locator.dart';

void main() {
  ///
  configureDependencies();

  ///
  runApp(const ProviderScope(child: MyApp()));
}


