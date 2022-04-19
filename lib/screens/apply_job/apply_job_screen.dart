import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:file_picker/file_picker.dart";
import "package:firebase_storage/firebase_storage.dart";
import 'package:job_connect/utils/WebViewScreen/webview_screen.dart';
import 'package:job_connect/utils/AlertMessage.dart';

class ApllyJobScreen extends StatefulWidget {
  final job;
  ApllyJobScreen(this.job);
  @override
  State<ApllyJobScreen> createState() => ApllyJobScreenState();
}

class ApllyJobScreenState extends State<ApllyJobScreen> {
  PlatformFile? pickerFile;
  UploadTask? uploadTask;
  String? filePath;
  bool check = false;
  String name = "";
  String avatar = "";

  Future getPdfAndUpLoad() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result?.files != null) {
        pickerFile = result!.files.first;
      }
    });
  }

  Future upLoadToFireBase() async {
    final path = "files/${pickerFile!.name}";
    final file = File(pickerFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapShot = await uploadTask!.whenComplete(() {});

    final urlDownLoad = await snapShot.ref.getDownloadURL();

    print("Link DownLoad ${urlDownLoad}");
    setState(() {
      filePath = urlDownLoad;
      print("File Path ${filePath}");
      uploadTask = null;
    });
  }

  void openPdf(BuildContext context, String filePath) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => WebViewScreen(filePath)));
  }

// widget build progress

  @override
  Widget build(BuildContext context) {
    final fileName = pickerFile?.name ?? "No file add";
    Widget buildProgess() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            final data = snapShot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 20,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              height: 50,
            );
          }
        });
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Apply ${widget.job["title"]} Job')),
        body: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Upload Resume/CV',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Upload your resume or cv to apply this job"),
                    SizedBox(
                      height: 50,
                    ),
                    pickerFile != null
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 9,
                                      offset: Offset(0, 3))
                                ]),
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/pdf.png",
                                    height: 80,
                                    width: 60,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        fileName,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          if (check)
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WebViewScreen(
                                                                filePath!)));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 16),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border:
                                                      Border.all(width: 1.0),
                                                ),
                                                child: Text(
                                                  'Preview',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                pickerFile = null;
                                                filePath = "";
                                              });
                                              ;
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(width: 1.0),
                                              ),
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 70,
                                  ),
                                  if (check == false)
                                    IconButton(
                                        onPressed: () {
                                          upLoadToFireBase();
                                          setState(() {
                                            check = true;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 40,
                                        ))
                                ]),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 9,
                                      offset: Offset(0, 3))
                                ]),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: GestureDetector(
                              onTap: () {
                                getPdfAndUpLoad();
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload),
                                    Text("Upload your file")
                                  ]),
                            ))

                    // if (filePath != null) ...[
                    //   ElevatedButton(
                    //     child: Text("Open View Pdf"),
                    //     onPressed: () {
                    //       openPdf(context, filePath!);
                    //     },
                    //   )
                    // ],
                    ,
                    SizedBox(height: 15),
                    buildProgess(),
                  ],
                )),
            if (check)
              Positioned(
                  bottom: 16,
                  left: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .get()
                            .then((value) {
                          name = value.data()?["displayName"];
                          avatar = value.data()?["photoUrl"];
                        });
                        print('N and V : ${name} ${avatar}');
                        if (!name.isEmpty && !avatar.isEmpty) {
                          FirebaseFirestore.instance
                              .collection("applications")
                              .add({
                            "jobId": widget.job["id"],
                            "jobTitle": widget.job["title"],
                            "jobLocation": widget.job["location"],
                            "jobSalary": widget.job["salary"],
                            "applyId": FirebaseAuth.instance.currentUser!.uid,
                            "applyName": name,
                            "applyAvatar": avatar,
                            "applyCV": filePath,
                          }).then((value) => showAlertDialog(context,
                                  title: 'Success',
                                  content: 'You applied a job'));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Text(
                          'Apply',
                          style: TextStyle(fontSize: 18),
                        ),
                      )))
          ],
        ));
  }
}
