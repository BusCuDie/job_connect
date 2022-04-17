import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_connect/screens/screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final screen = [HomeScreen(), ConnectScreen(), MessageScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(

        body: SafeArea(child: screen.elementAt(currentIndex)),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) => {
                  print(index),
                  setState(() {
                    currentIndex = index;
                  })
                },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt), label: 'Connect'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: 'Message'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.portrait_rounded), label: 'Profile')
            ]),
      ),
    );
  }
}
