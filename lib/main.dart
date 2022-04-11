import 'dart:async';

import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:job_connect/screens/screens.dart';
import 'package:job_connect/utils/GradientText/gradientText.dart';
import 'package:job_connect/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isloggin = true;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('user hiện tại ${user}');
      _navigateAuthen();
  }

  _navigateAuthen() async {
    await Future.delayed(Duration(seconds: 7), () => {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            // builder: (context) => user != null ? MainScreen() : DetailSignUpScreen()));
            builder: (context) => user != null ? MainScreen() : LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/logo.png',
            ),
            // SizedBox(height: 20,),
            // Text(
            //   'Welcom to Job Connect',
            //   style: GoogleFonts.poppins(
            //     textStyle: TextStyle(shadows: <Shadow>[
            //       Shadow(
            //           offset: Offset(0.0, 4.0),
            //           blurRadius: 4.0,
            //           color: Colors.grey)
            //     ]),
            //     fontWeight: FontWeight.w700,
            //     fontSize: 30.0,
            //   ),
            // ),
            SizedBox(height: 100,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ]),
    );
  }
}
