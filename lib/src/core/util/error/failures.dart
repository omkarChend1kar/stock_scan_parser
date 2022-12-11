import 'package:equatable/equatable.dart';

/// Failures abstract class for List of properties failures
abstract class Failures extends Equatable {
  final String? message;

  const Failures({required this.message});

  @override
  List<Object?> get props => [];
}

/// General Failures
/// this class is used to show Server Failures
class ServerFailure extends Failures {
  const ServerFailure({String? message}) : super(message: message ?? '');
}

class NetworkFailure extends Failures {
  const NetworkFailure({String? message}) : super(message: message ?? '');
}

class MiscellaneousFailure extends Failures {
  const MiscellaneousFailure({String? message}) : super(message: message ?? '');
}
