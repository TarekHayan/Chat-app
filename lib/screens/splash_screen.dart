import '../contsts.dart';
import 'check_user.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // بعد 3 ثواني يروح للصفحة الرئيسية
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CheckUser()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // الخلفية
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // اللوجو
            Image.asset(
              kpimage, // حط صورتك هنا
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 5),
            // الاسم
            Text(
              kPname, // اسمك
              style: TextStyle(
                color: kPrimyColor, // اللون الفسفوري
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100),
            Text(
              "By : Tarek Hayan", // اسمك
              style: TextStyle(
                color: Colors.white.withOpacity(0.4), // اللون الفسفوري
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
