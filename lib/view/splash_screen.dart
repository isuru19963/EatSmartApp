import 'package:flutter/material.dart';
import 'package:mvvm_app/viewModel/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashService.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/splash_img.png"),
    fit: BoxFit.cover),
    ),)
    );
  }
}
