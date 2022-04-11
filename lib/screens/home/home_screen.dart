import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:job_connect/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      children: [
        Center(
            child: Text(
                'Đây là màn hình Home ${FirebaseAuth.instance.currentUser}')),
        ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => new LoginScreen()),
                  (route) => false);
            },
            child: Text('Logout'))
      ],
    ));
  }
}
