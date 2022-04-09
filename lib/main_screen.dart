import 'package:flutter/material.dart';
import 'package:job_connect/screens/post/post_screen.dart';
import 'package:job_connect/screens/profile/profile_screen.dart';
import 'package:job_connect/screens/home/home_screen.dart';
class MainScreen extends StatefulWidget{
   const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen>  createState() => MainScreenState(); 
}
class MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final screen = [HomeScreen(), PostScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: screen.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => {
            print(index),
            setState(() {
              currentIndex = index;
            })
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(Icons.portrait_rounded), label: 'Profile')
          ]),
    );
  }
}
