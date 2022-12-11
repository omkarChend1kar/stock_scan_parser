import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class RegisterModule {
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();
  http.Client get httpClient => http.Client();
}
