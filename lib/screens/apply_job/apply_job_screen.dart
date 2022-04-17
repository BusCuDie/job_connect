import 'dart:io';

import "package:flutter/material.dart";
import "package:file_picker/file_picker.dart";
import "package:firebase_storage/firebase_storage.dart";
import 'package:job_connect/utils/WebViewScreen/webview_screen.dart';

class ApllyJobScreen extends StatefulWidget {
  @override
  State<ApllyJobScreen> createState() => ApllyJobScreenState();
}

class ApllyJobScreenState extends State<ApllyJobScreen> {
  PlatformFile? pickerFile;
  UploadTask? uploadTask;
  String? filePath;
  Future getPdfAndUpLoad() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result?.files!= null) {
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
              height: 50,
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
      appBar: AppBar(title: Text('Hiển')),
        body: Column(
      children: [
        ElevatedButton(
          child: Text("Upload pdf"),
          onPressed: getPdfAndUpLoad,
        ),
        Text(fileName),
        ElevatedButton(
          child: Text("Upload To FireBase"),
          onPressed: upLoadToFireBase,
        ),
        buildProgess(),
        if (filePath != null) ...[
          ElevatedButton(
            child: Text("Open View Pdf"),
            onPressed: () {
              openPdf(context, filePath!);
            },
          )
        ],
      ],
    ));
  }
}
