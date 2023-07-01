import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.unknown(Object data) = _unknownFailure;

  const factory Failure.illegalData(Object data) = _illegalDataFailure;

  const factory Failure.network() = _networkFailure;

  const factory Failure.other(String message) = _otherFailure;
}
