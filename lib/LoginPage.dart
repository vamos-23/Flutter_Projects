import 'package:kiit_cgpa_calculator/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:kiit_cgpa_calculator/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.width * 0.09;
    final double buttonWidth = screenSize.width * 0.37;
    final double buttonHeight = screenSize.height * 0.07;
    final double avatarRadius = screenSize.width * 0.25;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue, Colors.lightGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.03,
                        bottom: screenSize.height * 0.02),
                    child: CircleAvatar(
                      backgroundImage: const AssetImage(
                          'assets/images/kiit.png'),
                      radius: avatarRadius,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.0, bottom: 19.0),
                    child: Center(
                      child: Text('WELCOME',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.75,
                    height: 96,
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2.0, top: 2.0),
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: usernameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  hintText: 'Enter your name',
                                  prefixIcon: Icon(Icons.person, color: Colors.black54),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 2
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.5),
                      child: SizedBox(
                        height: buttonHeight,
                        width: buttonWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreenAccent,),
                          onPressed: () async {
                            var sharedPref = await SharedPreferences.getInstance();
                           await sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
                           await sharedPref.setString('username', usernameController.text);
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => HomePage(username: usernameController.text)),
                              );
                            }
                          }, //Navigation push to be inserted
                          child: Text(
                              'Proceed',
                              style: TextStyle(color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.width * 0.04)
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

