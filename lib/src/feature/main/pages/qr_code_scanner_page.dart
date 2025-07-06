import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ibrat_debate_scanner_app/src/common/routes/app_router.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../common/styles/app_colors.dart';

@RoutePage()
class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({super.key});

  @override
  State<QrCodeScannerPage> createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage>
    with WidgetsBindingObserver {
  MobileScannerController controller = MobileScannerController();
  bool _isScanning = true;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _cleanupCamera();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isDisposed) return;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _pauseCamera();
        break;
      case AppLifecycleState.resumed:
        _resumeCamera();
        break;
      default:
        break;
    }
  }

  Future<void> _cleanupCamera() async {
    if (_isDisposed) return;

    try {
      await controller.stop();
      await Future.delayed(const Duration(milliseconds: 100));
      controller.dispose();
    } catch (e) {
      debugPrint("Error cleaning up camera: $e");
    }
  }

  Future<void> _pauseCamera() async {
    if (_isDisposed || !_isScanning) return;

    try {
      await controller.stop();
    } catch (e) {
      debugPrint("Error pausing camera: $e");
    }
  }

  Future<void> _resumeCamera() async {
    if (_isDisposed || !_isScanning) return;

    try {
      await controller.start();
    } catch (e) {
      debugPrint("Error resuming camera: $e");
    }
  }

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    if (!_isScanning || _isDisposed) return;

    final List<Barcode> barcodes = barcodeCapture.barcodes;

    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      final String? code = barcode.rawValue;

      if (code != null && code.isNotEmpty) {
        setState(() {
          _isScanning = false;
        });

        debugPrint("Barcode detected here");
        debugPrint("Scanned QR: $code");

        // Stop and cleanup camera before navigation
        _stopAndNavigate(code);
      }
    }
  }

  Future<void> _stopAndNavigate(String code) async {
    try {
      await controller.stop();
      await Future.delayed(const Duration(milliseconds: 200));

      if (!_isDisposed && mounted) {
        _showConfirmationModal(code);
      }
    } catch (e) {
      debugPrint("Error stopping camera: $e");
      if (!_isDisposed && mounted) {
        _showConfirmationModal(code);
      }
    }
  }

  void _showConfirmationModal(String code) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.qr_code_scanner, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                context.localized.scanned_qr_code,
                style: context.textTheme.headlineSmall,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localized.successfully_scanned,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: SelectableText(
                  code,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.outline,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.localized.wanna_use,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.router.pop();
                _restartScanning();
              },
              child: Text(
                context.localized.scan_again,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog first
                Future.microtask(() {
                  context.router.replaceAll([const MainWrapperRoute()]);
                });
              },
              child: Text(
                context.localized.confirm,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _restartScanning() async {
    if (_isDisposed) return;

    setState(() {
      _isScanning = true;
    });

    try {
      await controller.start();
    } catch (e) {
      debugPrint("${context.localized.error_restarting_qrScanner} $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localized.scan_appbar),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await _cleanupCamera();
            if (mounted) {
              context.router.pop();
            }
          },
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _handleBarcode,
            errorBuilder: (context, error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      '${context.localized.camera_error} ${error.toString()}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.router.pop(),
                      child: Text(context.localized.go_back),
                    ),
                  ],
                ),
              );
            },
          ),
          // Overlay with scanning area
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          // Instructions
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                context.localized.camera_position,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
