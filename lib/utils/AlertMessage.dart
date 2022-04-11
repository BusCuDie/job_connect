import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,{String title='Alert',String content = 'Not thing'}) {  
  // Create button  
  Widget okButton = ElevatedButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text(title),  
    content: Text(content),  
    actions: [  
      okButton,  
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}