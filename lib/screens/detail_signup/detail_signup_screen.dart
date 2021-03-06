import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_connect/utils/AlertMessage.dart';
import 'package:job_connect/screens/screens.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import "package:job_connect/constant/data.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:avoid_keyboard/avoid_keyboard.dart";

class DetailSignUpScreen extends StatefulWidget {
  final email;
  final password;
  final avatar_default = "https://firebasestorage.googleapis.com/v0/b/jobconnect-20277.appspot.com/o/avatar%2Favt_default.png?alt=media&token=d1767b0f-675a-4fbe-8a9c-5e502f5131d0";
  const DetailSignUpScreen({Key? key, this.email, this.password})
      : super(key: key);
  @override
  State<DetailSignUpScreen> createState() {
    // TODO: implement createState
    return DetailSignUpScreenState();
  }
}

class DetailSignUpScreenState extends State<DetailSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController headlineController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool show = false;
  String? industryValue = "Aviation";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Your detail'),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: EdgeInsets.all(24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About you*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: displayNameController,
                              decoration: InputDecoration(
                                hintText: 'Pham Dinh Hien .v.v.v',
                                // border: ,
                                // fillColor: Color.fromARGB(255, 180, 202, 235),
                                // filled: true,
                                labelText: 'Display name',
                                labelStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                errorStyle: TextStyle(fontSize: 14),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Display name is empty, please enter';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: headlineController,
                              decoration: InputDecoration(
                                hintText: 'Slogan, Bio .v.v.v',
                                // border: ,
                                // fillColor: Color.fromARGB(255, 180, 202, 235),
                                // filled: true,
                                labelText: 'HeadLine',
                                labelStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                errorStyle: TextStyle(fontSize: 14),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Headline is empty, please enter';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Text(
                              'Industry',
                              style: GoogleFonts.poppins(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select industry',
                                  style: TextStyle(fontSize: 18),
                                ),
                                items: industryList
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    industryValue = value as String;
                                  });
                                },
                                value: industryValue,
                                buttonHeight: 40,
                                buttonWidth: 140,
                                itemHeight: 40,
                                buttonDecoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.grey))),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Text(
                              'Location',
                              style: GoogleFonts.poppins(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: countryController,
                              decoration: InputDecoration(
                                  hintText: 'Viet Nam v.v.v',
                                  // border: ,
                                  // fillColor: Color.fromARGB(255, 180, 202, 235),
                                  // filled: true,
                                  errorStyle: TextStyle(fontSize: 14),
                                  labelText: 'Country',
                                  labelStyle: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Country is empty, please enter';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: cityController,
                              decoration: InputDecoration(
                                hintText: 'Ho Chi Minh City .v.v.v',
                                // border: ,
                                // fillColor: Color.fromARGB(255, 180, 202, 235),
                                // filled: true,

                                errorStyle: TextStyle(fontSize: 14),
                                labelText: 'State',
                                labelStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'State is empty, please enter';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Contact information',
                              style: GoogleFonts.poppins(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                  hintText: '0971****** v.v.v',
                                  // border: ,
                                  // fillColor: Color.fromARGB(255, 180, 202, 235),
                                  // filled: true,
                                  errorStyle: TextStyle(fontSize: 14),
                                  labelText: 'Phone number',
                                  labelStyle: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone is empty, please enter';
                                } else if (!RegExp(
                                        r"^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$")
                                    .hasMatch(value)) {
                                  return 'Phone is invalid, please again';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    // final data = FirebaseFirestore.instance
                                    //     .collection('users')
                                    //     .where("phoneNumber",isEqualTo: "0971109618")
                                    //     .get()
                                    //     .then((QuerySnapshot querry) {
                                    //   print(querry.docs);
                                    // });

                                    final UserCredential cridential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: widget.email,
                                                password: widget.password);
                                    if (cridential.user != null) {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(cridential.user!.uid)
                                          .set({
                                        'uid': cridential.user!.uid,
                                        'displayName':
                                            displayNameController.text,
                                        'email': widget.email,
                                        'photoUrl': widget.avatar_default,
                                        'headLine': headlineController.text,
                                        'industry': industryValue,
                                        'country': countryController.text,
                                        'state': cityController.text,
                                        'phoneNumber': phoneController.text
                                      }, SetOptions(merge: true)).then(
                                              (value) =>
                                                  print('Th??m th??nh c??ng'));
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print(
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      print(
                                          'The account already exists for that email.');
                                      showAlertDialog(context,
                                          title: 'T??i kho???n ???? t???n t???i',
                                          content:
                                              'Vui l??ng s??? d???ng t??i kho???n kh??c');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new CongratulationScreen()),
                                      (route) => false);
                                }
                              },
                              child: Text(
                                "Complete",
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  padding: EdgeInsets.symmetric(vertical: 16)),
                            ),
                          ],
                        ))
                  ]),
            ),
          ),
        ));
  }
}
