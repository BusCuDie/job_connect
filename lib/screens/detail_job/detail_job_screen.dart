import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_connect/screens/apply_job/apply_job_screen.dart';
import 'package:job_connect/utils/AlertMessage.dart';

class DetailJobScreen extends StatelessWidget {
  final job;
  bool exist = false;
  DetailJobScreen({Key? key, this.job}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Detail',
            style: TextStyle(color: Colors.blue),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Column(children: [
                    Image.asset(
                      'images/logo.png',
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      job["title"],
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Posted by ${job["createByName"]}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.send,
                              size: 18,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${job["application"]} Applications',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${job["type"]}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 20,
                        color: Colors.grey),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Salary',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                '${job["salary"]} \$',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                '${job["location"]}',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Experience',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                '${job["experience"]}',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Workplace type',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                '${job["workplaceType"]}',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 20,
                        color: Colors.grey),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              job["description"],
                              style: TextStyle(fontSize: 16),
                            )
                          ]),
                    )
                  ]),
                ),
              ]),
            ),
            Positioned(
                bottom: 10,
                left: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Save Job',
                          style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("applications")
                            .where("jobId", isEqualTo: job["id"])
                            .where("applyId",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .get()
                            .then((value) {
                          value.size > 0
                              ? showAlertDialog(context,
                                  title: "Applied",
                                  content: 'You applied this job')
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      new ApllyJobScreen(job)));
                        });
                        if (exist) {
                        } else {}
                      },
                      child: const Text('Apply Job',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ))
          ],
        ));
  }
}
