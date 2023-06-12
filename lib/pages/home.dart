import 'package:flutter/material.dart';
import 'package:logon/pages/login.dart';
import 'package:logon/pages/signup.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Identity Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login.avif'),
                    ),
                  ),
                ),
                Column(
                  children: [
                    MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      color: Colors.yellow,
                      height: 60,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        elevation: 5,
                        color: Colors.yellow,
                        height: 60,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
