import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/scheduler.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import '../../../setup.dart';
import '../../common/local/app_storage.dart';
import '../../common/routes/app_router.dart';
import '../../common/server/api/api.dart';
import '../../common/utils/jwt_utils.dart';

@RoutePage()
class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup fade animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start animation after build
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    debugPrint('🚀 ===== App Initialization Started =====');

    final String? token = await AppStorage.$read(key: StorageKey.accessToken);
    final String? refreshToken = await AppStorage.$read(
      key: StorageKey.refreshToken,
    );

    if (token == null || token.isEmpty) {
      debugPrint("❌ No access token found");
      context.router.replaceAll([const LoginRoute()]);
      return;
    }

    // Analyze current tokens
    analyzeToken(token, tokenType: 'Access Token');
    if (refreshToken != null && refreshToken.isNotEmpty) {
      analyzeToken(refreshToken, tokenType: 'Refresh Token');
    }

    // Check if token is expired
    if (isAccessTokenExpired(token)) {
      debugPrint('⏳ Access token expired. Attempting refresh...');

      final refreshed = await ApiService.refreshAccessToken();

      if (refreshed) {
        final String? newToken = await AppStorage.$read(
          key: StorageKey.accessToken,
        );
        if (newToken != null && newToken.isNotEmpty) {
          debugPrint('🔄 Analyzing new token after refresh...');
          analyzeToken(newToken, tokenType: 'New Access Token');

          if (!isAccessTokenExpired(newToken)) {
            debugPrint('✅ Token refreshed successfully.');
            context.router.replaceAll([const MainWrapperRoute()]);
          } else {
            debugPrint('❌ New token is still expired.');
            context.router.replaceAll([const LoginRoute()]);
          }
        } else {
          debugPrint('❌ Refresh failed - no new token received.');
          context.router.replaceAll([const LoginRoute()]);
        }
      } else {
        debugPrint('❌ Token refresh failed.');
        context.router.replaceAll([const LoginRoute()]);
      }
    } else {
      // Token is valid
      debugPrint('✅ Token is valid. Proceeding to main app.');
      context.router.replaceAll([const MainWrapperRoute()]);
    }

    debugPrint('🏁 ===== App Initialization Completed =====');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            'Ibrat Debate Team',
            style: context.textTheme.titleLarge?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
