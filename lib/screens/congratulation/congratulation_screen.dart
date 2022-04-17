import 'package:flutter/material.dart';
import 'package:job_connect/main_screen.dart';

class CongratulationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo.png',
                  height: 100,
                  width: 100,
                ),
                Text(
                  "Job Connect",
                  style: TextStyle(
                      color: Color.fromARGB(255, 2, 55, 99),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 100,)
                ,
                     Text(
                  "Congrats!",
                  style: TextStyle(
                      color: Color.fromARGB(255, 6, 128, 228),
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                     Text(
                  "Your account is ready to use",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      ),

                ),
                   SizedBox(height: 10,),
                ElevatedButton(
             style: ElevatedButton.styleFrom(
               padding: EdgeInsets.symmetric(horizontal: 60,vertical: 10),
               shape: const RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(Radius.circular(30)),
               )
             ),
                  onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MainScreen()));
                }, child: Text('Go to home',style: TextStyle(fontSize: 20),))
              ]),
        ));
  }
}
