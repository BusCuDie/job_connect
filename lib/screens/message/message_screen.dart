import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget{
@override
  State<StatefulWidget> createState()=> MessageScreenState();
}

class MessageScreenState extends State<MessageScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width ,
        child:const Text("Message Screen"),
      ),
    );
  }
}