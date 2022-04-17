import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_connect/main_screen.dart';
import 'package:job_connect/utils/AlertMessage.dart';
import 'package:job_connect/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                      errorStyle: TextStyle(fontSize: 14),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is empty, please enter';
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
                        errorStyle: TextStyle(fontSize: 14),
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
                        try {
                          final cridential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          print('Thông tin đăng nhập ${cridential}');
                          if (cridential != null) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get()
                                .then((documentSnapshot) => {
                                      //  print('current user : ${documentSnapshot.data()?["uid"]}')
                                     
                                    });
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => new MainScreen()),
                                (route) => false);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('The password provided is too weak.');
                            showAlertDialog(context,
                                title: 'No user found for that email',
                                content: 'Please again');
                          } else if (e.code == 'wrong-password') {
                            showAlertDialog(context,
                                title: 'Wrong password',
                                content: 'Please again');
                          }
                        } catch (e) {
                          print(e);
                        }
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => new SignupScreen()));
                      },
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
