import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool show = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'images/logo.png',
              height: 150,
              width: 150,
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.only(
          //     left: 30,
          //   ),
          //   child: Text(
          //     'Welcom Back!!!',
          //     style: GoogleFonts.poppins(
          //       textStyle: TextStyle(shadows: <Shadow>[
          //         Shadow(
          //             offset: Offset(0.0, 4.0),
          //             blurRadius: 4.0,
          //             color: Colors.grey)
          //       ]),
          //       fontWeight: FontWeight.w700,
          //       fontSize: 30.0,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Sign in to your account',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color.fromARGB(255, 180, 202, 235),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is empty, please enter';
                      } else if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)) {
                        return 'Email is invalid, please again';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      obscureText: show,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.key,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: show
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                          },
                        ),
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromARGB(255, 180, 202, 235),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is empty, please enter';
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                            .hasMatch(value)) {
                          return 'Password must have at least 8 character, include number,\nboth uppercase and lowercase letter,  ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print(
                            'Email: ${emailController.text}\n Password: ${passwordController.text}');
                      }
                      try {
                        final cridential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 16)),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Create an account ?",
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ))
        ]),
      ),
    );
  }
}
