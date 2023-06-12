import 'package:flutter/material.dart';
import 'package:logon/pages/auth.dart';
import 'package:logon/pages/snack.dart';
import 'home.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _dobcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _confirmpasscontroller = TextEditingController();
  bool _isLoading = false;

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().SignUserUp(
      email: _emailcontroller.text,
      dob: _dobcontroller.text,
      password: _passcontroller.text,
      confirm: _confirmpasscontroller.text,
    );

    setState(() {
      _isLoading = false;
    });
    if (res != 'Success') {
      showSnackBar(res, context);
    } else {
      showSnackBar("User Created Successfully", context);
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
            // Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          makeInput(label: "Email", cont: _emailcontroller),
                          makeInput(label: "Date of Birth", cont: _dobcontroller),
                          makeInput(label: "Password", obscureText: true, cont: _passcontroller),
                          makeInput(label: "Confirm Password", obscureText: true, cont: _confirmpasscontroller),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: [
                            MaterialButton(
                              minWidth: 200,
                              onPressed: signUpUser,
                              // elevation: 5,
                              color: Colors.greenAccent,
                              height: 60,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      child: _isLoading
                                          ? const Center(
                                              child: CircularProgressIndicator(),
                                            )
                                          : const Text('Sign Up', style: TextStyle(fontSize: 20))),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(height: 10),
                                const Text(
                                  "Already have an account? ",
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                  },
                                  child: const Text(
                                    "Log in",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
