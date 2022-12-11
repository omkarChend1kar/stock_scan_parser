// ignore: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:injectable/injectable.dart';
import 'package:stock_scan_parser/src/core/common/services/service_locator.config.dart';

final sl = GetIt.instance;

@injectableInit
void configureDependencies() => sl.init();
