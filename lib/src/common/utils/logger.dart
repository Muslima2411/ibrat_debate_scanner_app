import 'dart:developer' as developer;

import '../constants/config.dart';

mixin LogBufferMixin on Object {
  bool get shouldLog => Config.environment.isDevelopment;

  late final String _name = runtimeType.toString();

  void log(void Function(StringBuffer b) assemble) {
    if (shouldLog) {
      final buffer = StringBuffer(_name)..write(' | ');
      assemble(buffer);
    }
  }

  void logData(Object? data) {
    if (shouldLog) log((b) => b.write(data));
  }
}

/// Tracing information
final void Function(Object? message) fine = _logAll('FINE', 500);

/// Static configuration
final void Function(Object? message) config = _logAll('CONF', 700);

/// Informational messages
final void Function(Object? message) info = _logAll('INFO', 800);

/// Potential problems
final void Function(Object exception, [StackTrace? stackTrace, String? reason])
    warning = _logAll('WARN', 900);

/// Serious failures
final void Function(Object error, [StackTrace stackTrace, String? reason])
    severe = _logAll('ERR!', 1000);

void Function(
  Object? message, [
  StackTrace? stackTrace,
  String? reason,
]) _logAll(String prefix, int level) =>
    (Object? message, [StackTrace? stackTrace, String? reason]) {
      if (!Config.environment.isDevelopment) return;

      final coloredPrefix = switch (level) {
        500 => rgbPrefix(prefix, r: 0, g: 255, b: 255),
        700 => rgbPrefix(prefix),
        800 => rgbPrefix(prefix, r: 0, g: 255, b: 0),
        900 => rgbPrefix(prefix, r: 255, g: 255, b: 0),
        1000 => rgbPrefix(prefix, r: 255, g: 0, b: 0),
        _ => prefix,
      };

      developer.log(
        '[$coloredPrefix] ${reason ?? message}',
        level: level,
        name: 'CashTrack',
        error: message is Exception || message is Error ? message : null,
        stackTrace: stackTrace,
      );
    };

String rgbPrefix(
  String text, {
  int r = 0,
  int g = 0,
  int b = 0,
}) =>
    '\x1B[38;2;$r;$g;${b}m$text\x1B[0m';
