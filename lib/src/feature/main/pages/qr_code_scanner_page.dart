import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class QrCodeScannerPage extends StatelessWidget {
  const QrCodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR")),
      body: MobileScanner(
        onDetect: (barcode) {
          final String code = barcode.raw.toString();
          // Navigator.pop(context);
          // // Handle scanned QR
          debugPrint("Scanned QR: $code");
        },
      ),
    );
  }
}
