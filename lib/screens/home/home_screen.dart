import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:job_connect/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

const banner = [
  "images/banner2.png",
  "images/banner3.png",
  "images/banner4.png"
];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String name = "";
  String avatar = "";
  List<dynamic> jobs = [];
  @override
  void initState() {
    super.initState();
  }

  getName() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      print(value);
      setState(() {
        name = value.data()?["displayName"];
        avatar = value.data()?["photoUrl"];
      });
    });
    return Padding(
      padding: EdgeInsets.only(top: 3, bottom:10, right: 20,left: 16),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: avatar != ""
                  ? Image.network(
                      avatar,
                      fit: BoxFit.fill,
                      height: 50,
                      width: 50,
                    )
                  : Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/jobconnect-20277.appspot.com/o/avatar%2Favt_df.png?alt=media&token=1b517f9c-aa64-4291-a482-4f94fa1741d4',
                      fit: BoxFit.fill,
                      height: 50,
                      width: 50,
                    )),
          SizedBox(
            width: 20,
          ),
          Text(
            "Hi, ${name} !",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  getJob(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 25,left: 8,right: 8),
            child: Column(children: [
              getName(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: CarouselSlider(
                  options: CarouselOptions(
                    // aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: banner.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          child: Image.asset(
                            i,
                            height: 300,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        );
                      },
                    );
                  }).toList(),
                ),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                    // Shadow position
                  ),
                ]),
              ),
            ]),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.7),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(

            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          )
        ],
      ),
    ));
  }
}
