// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import "package:flutter/material.dart"
    show BuildContext, Color, ScaffoldMessenger, SnackBar, Text;

import "logger.dart";

// TODO(Boburbek): Need check Firebase Crashlytics
sealed class ErrorUtil {
  const ErrorUtil._();

  static Future<void> logError(
    Object exception,
    StackTrace stackTrace, {
    String? hint,
  }) async {
    try {
      // _$captureException(exception, stackTrace, hint).ignore();

      severe(exception, stackTrace);
    } on Object catch (error, stackTrace) {
      warning(
        'Error while logging error "$error" inside ErrorUtil.logError',
        stackTrace,
      );
    }
  }

  static Never throwWithStackTrace(Object error, StackTrace stackTrace) =>
      Error.throwWithStackTrace(error, stackTrace);

  static void showSnackBar(BuildContext context, Object message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$message"),
          backgroundColor: const Color(0xFFFF0000),
        ),
      );
}

// Future<void> _$captureException(
//   Object exception,
//   StackTrace stackTrace,
//   String? hint,
// ) =>
    // FirebaseCrashlytics.instance.recordError(exception, stackTrace, reason: hint);
