import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../setup.dart';
import '../../common/routes/app_router.dart';

@RoutePage()
class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Check if widget is still mounted before navigating
    if (!mounted) return;

    // Check token and navigate accordingly
    if (token != null) {
      // Token exists, navigate to main app
      context.router.replaceAll([const MainWrapperRoute()]);
    } else {
      // No token, navigate to login
      context.router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Initializing...',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
