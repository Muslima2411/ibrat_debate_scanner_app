import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/scheduler.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import '../../../setup.dart';
import '../../common/routes/app_router.dart';

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
    // Wait for 2 seconds
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    // Navigate based on token
    if (token != null) {
      context.router.replaceAll([const MainWrapperRoute()]);
    } else {
      context.router.replaceAll([const LoginRoute()]);
    }
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
