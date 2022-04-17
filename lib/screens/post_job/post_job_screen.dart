import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_connect/utils/AlertMessage.dart';
import 'package:job_connect/screens/screens.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import "package:job_connect/constant/data.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:avoid_keyboard/avoid_keyboard.dart";

class PostJobScreen extends StatefulWidget {
  @override
  State<PostJobScreen> createState() => PostJobScreenState();
}

class PostJobScreenState extends State<PostJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  String? industryValue = "Aviation";
  String? workplaceType = "On-site";
  String? jobType = "Full-time";
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a job'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Job title*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Add job title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Job title is empty, please enter';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Workplace type*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: workplaceList
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
                            workplaceType = value as String;
                          });
                        },
                        value: workplaceType,
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                        buttonDecoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Job Location*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: 'Ho Chi Minh',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Job location is empty, please enter';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Industry*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
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
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey))),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Job type*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: jobTypeList
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
                            jobType = value as String;
                          });
                        },
                        value: jobType,
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                        buttonDecoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey))),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Experience*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: experienceController,
                      decoration: InputDecoration(
                        hintText: 'Job experience',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Experience is empty, please enter';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Job salary*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: salaryController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.attach_money),
                        hintText: '500-700',
                        errorStyle: TextStyle(fontSize: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Salary is empty, please enter';
                        } else if (!RegExp(r"([\d])+-?([\d])*")
                            .hasMatch(value)) {
                          return 'Salary is invalid, please again';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Description*',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 6,
                      minLines: 1,
                      maxLength: 200,
                      decoration: InputDecoration(
                        hintText: 'Job Description',
                        errorStyle: TextStyle(fontSize: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is empty, please enter';
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
                          FirebaseFirestore.instance.collection("jobs").add({
                            'title': titleController.text,
                            'workplaceType': workplaceType,
                            'location': locationController.text,
                            'industry': industryValue,
                            'type': jobType,
                            'salary': salaryController.text,
                            'experience': experienceController.text,
                            'description': descriptionController.text,
                            'createdBy': uid,
                            "createByName": FirebaseAuth.instance.currentUser!.displayName,
                            "application":0,
                            "jobApply":[],
                            'isClose' : false,
                          }).then((value) {
                            print('value ${value.id}');
                            showAlertDialog(context,
                                title: 'Success', content: 'Added a job');
                            titleController.text = "";
                            locationController.text = "";
                            salaryController.text = "";
                            experienceController.text = "";
                            descriptionController.text = "";
                          }).catchError((err) => showAlertDialog(context,
                              title: 'Error', content: err?.message));
                        }
                      },
                      child: Text(
                        "Add job",
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
    );
  }
}
