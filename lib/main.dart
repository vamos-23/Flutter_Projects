import 'dart:async';
//import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:kiit_cgpa_calculator/HomePage.dart';
import 'package:kiit_cgpa_calculator/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();//flutter is initialized
  // if (Platform.isAndroid) {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  // }
  runApp(SGPACalculator());
}

class SGPACalculator extends StatelessWidget {
  const SGPACalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent
      ),
      home:  SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget{
    const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
static const String KEYLOGIN = 'Login';
  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue, Colors.lightGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: screenSize.height * 0.07),
            child: Wrap(
              children: [
                AutoSizeText(
                  'KIIT SGPA/CGPA CALCULATOR',
                  maxLines: 2,
                  maxFontSize: 20,
                  minFontSize: 15,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    var username = sharedPref.getString('username');
    Timer(Duration(seconds:1),() {
        if (isLoggedIn != null && isLoggedIn) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePage(username: username ?? 'Guest' ),
              ));
        }
      else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPage(),
            ));
      }

    },);
  }
}







