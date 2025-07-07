import 'dart:convert';
import 'package:flutter/cupertino.dart';

bool isAccessTokenExpired(String token) {
  try {
    debugPrint('🔍 Checking token expiry...');

    if (token.isEmpty) {
      debugPrint('❌ Token is empty');
      return true;
    }

    final parts = token.split('.');
    debugPrint('📋 Token parts count: ${parts.length}');

    if (parts.length != 3) {
      debugPrint('❌ Invalid token format (expected 3 parts)');
      return true;
    }

    final payload = utf8.decode(
      base64Url.decode(base64Url.normalize(parts[1])),
    );
    final Map<String, dynamic> payloadMap = json.decode(payload);

    debugPrint('📄 Decoded payload: $payloadMap');

    if (!payloadMap.containsKey('exp')) {
      debugPrint('❌ No expiry field found in token');
      return true;
    }

    final expiry = payloadMap['exp'] as int;
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
    final currentDate = DateTime.now();

    debugPrint('⏰ Current date: $currentDate');
    debugPrint('🕒 Token expiry date: $expiryDate');
    debugPrint('📊 Expiry timestamp: $expiry');
    debugPrint(
      '📊 Current timestamp: ${currentDate.millisecondsSinceEpoch ~/ 1000}',
    );

    final isExpired = currentDate.isAfter(expiryDate);
    final timeDifference = expiryDate.difference(currentDate);

    if (isExpired) {
      debugPrint('❌ Token is EXPIRED by: ${timeDifference.abs()}');
    } else {
      debugPrint('✅ Token is VALID for: $timeDifference');
    }

    // Additional useful info
    if (payloadMap.containsKey('iat')) {
      final issuedAt = payloadMap['iat'] as int;
      final issuedDate = DateTime.fromMillisecondsSinceEpoch(issuedAt * 1000);
      debugPrint('📅 Token issued at: $issuedDate');
    }

    if (payloadMap.containsKey('user_id')) {
      debugPrint('👤 User ID: ${payloadMap['user_id']}');
    }

    return isExpired;
  } catch (e) {
    debugPrint('⚠️ Error decoding JWT: $e');
    debugPrint(
      '🔍 Token preview: ${token.length > 50 ? token.substring(0, 50) + '...' : token}',
    );
    return true; // If something went wrong, assume expired
  }
}

// Helper function to get token info without expiry check
Map<String, dynamic>? getTokenInfo(String token) {
  try {
    if (token.isEmpty) return null;

    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload = utf8.decode(
      base64Url.decode(base64Url.normalize(parts[1])),
    );
    return json.decode(payload);
  } catch (e) {
    debugPrint('⚠️ Error getting token info: $e');
    return null;
  }
}

// Function to print detailed token analysis
void analyzeToken(String token, {String tokenType = 'Token'}) {
  debugPrint('🔬 ===== $tokenType Analysis =====');

  if (token.isEmpty) {
    debugPrint('❌ $tokenType is empty');
    return;
  }

  final info = getTokenInfo(token);
  if (info == null) {
    debugPrint('❌ Failed to decode $tokenType');
    return;
  }

  debugPrint('📄 $tokenType payload: $info');

  if (info.containsKey('exp')) {
    final expiry = info['exp'] as int;
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
    final currentDate = DateTime.now();
    final isExpired = currentDate.isAfter(expiryDate);
    final timeDifference = expiryDate.difference(currentDate);

    debugPrint('⏰ Current: $currentDate');
    debugPrint('🕒 Expires: $expiryDate');
    debugPrint(
      '${isExpired ? '❌' : '✅'} Status: ${isExpired ? 'EXPIRED' : 'VALID'}',
    );
    debugPrint(
      '⏳ Time diff: ${isExpired ? timeDifference.abs() : timeDifference}',
    );
  }

  if (info.containsKey('iat')) {
    final issuedAt = info['iat'] as int;
    final issuedDate = DateTime.fromMillisecondsSinceEpoch(issuedAt * 1000);
    debugPrint('📅 Issued: $issuedDate');
  }

  debugPrint('🔬 ===== End $tokenType Analysis =====');
}
