import 'package:flutter/material.dart';
import 'package:logon/pages/auth.dart';
import 'package:logon/pages/first.dart';
import 'package:logon/pages/home.dart';
import 'package:logon/pages/signup.dart';
import 'package:logon/pages/snack.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emalcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  void logUserIn() async {
    String res = await AuthMethods().LogUserIn(email: _emalcontroller.text, password: _passwordcontroller.text);
    if (res == 'Success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const FirstPage(),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Log in to your account",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        makeInput(label: "Email", cont: _emalcontroller),
                        makeInput(label: "Password", obscureText: true, cont: _passwordcontroller),
                        // makeInput(label: "Confirm Password", obscureText: true),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: MaterialButton(
                        minWidth: 200,
                        onPressed: logUserIn,
                        // elevation: 5,
                        color: Colors.greenAccent,
                        height: 60,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      const Text(
                        "Dont have an account? ",
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.8,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.9,
                        image: AssetImage('assets/background.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, cont}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: cont,
          obscureText: obscureText,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
