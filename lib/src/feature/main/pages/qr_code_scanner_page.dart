import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibrat_debate_scanner_app/src/common/routes/app_router.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../common/styles/app_colors.dart';
import '../../../data/entity/ticket_model/ticket_model.dart';
import '../../../data/entity/user_model/user_model.dart';
import '../view_models/qr_code_scanner_vm.dart';

@RoutePage()
class QrCodeScannerPage extends ConsumerStatefulWidget {
  const QrCodeScannerPage({super.key});

  @override
  ConsumerState<QrCodeScannerPage> createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends ConsumerState<QrCodeScannerPage>
    with WidgetsBindingObserver {
  MobileScannerController controller = MobileScannerController();
  QrCodeScannerViewModel? viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() {
      if (mounted) {
        ref.read(qrCodeScannerViewModelProvider).reset();
      }
    });
  }

  @override
  void dispose() {
    // Don't try to modify provider state during disposal
    // The viewModel will be disposed automatically by Riverpod
    _cleanupCamera();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check if widget is still mounted before accessing viewModel
    if (!mounted) return;

    if (viewModel?.state.isDisposed == true) return;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _pauseCamera();
        // Use Future to delay state modification
        Future(() {
          if (mounted) viewModel?.pauseScanning();
        });
        break;
      case AppLifecycleState.resumed:
        _resumeCamera();
        // Use Future to delay state modification
        Future(() {
          if (mounted) viewModel?.resumeScanning();
        });
        break;
      default:
        break;
    }
  }

  Future<void> _cleanupCamera() async {
    // Remove dependency on viewModel state during cleanup
    try {
      await controller.stop();
      await Future.delayed(const Duration(milliseconds: 100));
      controller.dispose();
    } catch (e) {
      debugPrint("Error cleaning up camera: $e");
    }
  }

  Future<void> _pauseCamera() async {
    if (viewModel?.state.isDisposed == true ||
        viewModel?.state.isScanning != true)
      return;

    try {
      await controller.stop();
    } catch (e) {
      debugPrint("Error pausing camera: $e");
    }
  }

  Future<void> _resumeCamera() async {
    if (viewModel?.state.isDisposed == true ||
        viewModel?.state.isScanning != true)
      return;

    try {
      await controller.start();
    } catch (e) {
      debugPrint("Error resuming camera: $e");
    }
  }

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    if (viewModel?.state.isScanning != true ||
        viewModel?.state.isDisposed == true)
      return;

    final List<Barcode> barcodes = barcodeCapture.barcodes;

    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      final String? code = barcode.rawValue;

      if (code != null && code.isNotEmpty) {
        debugPrint("Barcode detected: $code");

        // Stop camera and handle the scanned code through view model
        _stopAndHandleCode(code);
      }
    }
  }

  Future<void> _stopAndHandleCode(String code) async {
    try {
      await controller.stop();
      await Future.delayed(const Duration(milliseconds: 200));

      if (!mounted) return;

      // Handle the scanned code through view model
      await viewModel?.handleScannedCode(code);
    } catch (e) {
      debugPrint("Error stopping camera: $e");
      viewModel?.setError("Camera error: $e");
    }
  }

  void _showConfirmationModal(TicketModel ticket, UserModel user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(qrCodeScannerStateProvider);

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              actionsPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              title: Row(
                children: [
                  Icon(Icons.qr_code_scanner, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      context.localized.scanned_qr_code,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localized.successfully_scanned,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Unified Info Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.localized.user_info,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            context.localized.name,
                            user.name ?? '-',
                            context,
                          ),
                          _buildInfoRow(
                            context.localized.username,
                            user.username ?? '-',
                            context,
                          ),
                          _buildInfoRow(
                            context.localized.phone,
                            user.phone ?? '-',
                            context,
                          ),
                          _buildInfoRow(
                            context.localized.age_group,
                            user.age ?? '-',
                            context,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      context.localized.confirm_checkin_prompt,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: state.isConfirming
                      ? null
                      : () {
                          Navigator.of(dialogContext).pop();
                          _restartScanning();
                        },
                  child: Text(
                    context.localized.scan_again,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: state.isConfirming
                          ? Colors.grey
                          : AppColors.primary,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: state.isConfirming
                      ? null
                      : () async {
                          // ✅ Save ALL context-dependent values BEFORE any async operations
                          final successTitle = context.localized.success_title;
                          final successMessage =
                              context.localized.success_message;
                          final okLabel = context.localized.ok;

                          // ✅ Save theme data before async operations
                          final theme = Theme.of(context);
                          final colorScheme = theme.colorScheme;

                          // ✅ Save valid context and router before any async operations
                          final router = context.router;

                          await viewModel?.confirmCheckIn();
                          if (!mounted) return;

                          // Close the confirmation dialog using the dialog's context
                          Navigator.of(dialogContext).pop();

                          // Add a small delay to ensure dialog is closed
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );

                          // Show success dialog with pre-saved values
                          if (mounted) {
                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (successDialogContext) {
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    if (successDialogContext.mounted) {
                                      Navigator.of(successDialogContext).pop();
                                    }
                                  },
                                );

                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          successTitle,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                color: colorScheme.onSurface,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: Text(
                                    successMessage,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                );
                              },
                            );
                          }

                          if (mounted) {
                            viewModel?.reset();
                            router.replaceAll([const MainWrapperRoute()]);
                          }
                        },
                  child: state.isConfirming
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.colorScheme.onSurface,
                            ),
                          ),
                        )
                      : Text(
                          context.localized.confirm,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _restartScanning() async {
    if (viewModel?.state.isDisposed == true) return;

    viewModel?.restartScanning();

    try {
      await controller.start();
    } catch (e) {
      debugPrint("${context.localized.error_restarting_qrScanner} $e");
      viewModel?.setError("Error restarting scanner: $e");
    }
  }

  // Add this to your build method in the Consumer widget:

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(qrCodeScannerStateProvider);
        viewModel = ref.read(qrCodeScannerViewModelProvider);

        // Handle navigation back when shouldNavigateBack is true
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && state.shouldNavigateBack) {
            viewModel?.resetNavigationFlag();

            Future.microtask(() async {
              if (mounted) {
                await _cleanupCamera();
                context.router.pop();
              }
            });
          }
        });

        // Show confirmation modal when we have ticket and user data
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted &&
              state.ticket != null &&
              state.user != null &&
              !state.shouldNavigateBack &&
              !state.isConfirming) {
            Future.microtask(() {
              if (mounted) {
                _showConfirmationModal(state.ticket!, state.user!);
              }
            });
          }
        });

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
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Loading indicator
              if (state.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 16),
                        Text(
                          context.localized.processing_ticket,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

              // Error message with improved styling
              if (state.errorMessage != null)
                Positioned(
                  top: 100,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.error, color: Colors.white),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                state.errorMessage!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Future(() {
                                  if (mounted) viewModel?.clearError();
                                });
                              },
                            ),
                          ],
                        ),
                        if (state.shouldNavigateBack) ...[
                          const SizedBox(height: 8),
                          Text(
                            context.localized.returning_previous_page,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildInfoRow(String label, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: context.colorScheme.onSurface,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    ),
  );
}
