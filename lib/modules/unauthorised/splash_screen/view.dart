import 'package:courtclick_mt/core/constanst/assets_constants/assets_contant.dart';
import 'package:courtclick_mt/core/navigation/custom_page_route.dart';
import 'package:courtclick_mt/modules/unauthorised/login_screen/view/view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkRedirect();
  }

  Future<void> _checkRedirect() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      SmoothPageRoute(page: const LoginPageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: Image.asset(
          AppImages.splashLogo,
          width: size.width * 0.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
