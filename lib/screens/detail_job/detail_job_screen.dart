import 'package:flutter/material.dart';

class DetailJobScreen extends StatelessWidget {
  final job;

  const DetailJobScreen({Key? key, this.job}) : super(key: key);
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
      body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10, top: 10, right: 16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                child: Column(children: [
                  Image.asset(
                    'images/logo.png',
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    job["title"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Posted by ${job["createByName"]}'),
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
                            style: TextStyle(color: Colors.grey),
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
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  const Divider(
                      height: 1, thickness: 1, indent: 20, color: Colors.grey),
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
                            Text('Salary'),
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              '${job["salary"]} \$',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Location'),
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              '${job["location"]}',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Experience'),
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              '${job["salary"]} \$',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Workplace type'),
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              '${job["workplaceType"]}',
                              style: TextStyle(color: Colors.blue),
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
                      height: 1, thickness: 1, indent: 20, color: Colors.grey),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Description'),
                  Text(job["description"])
                ]),
              )
            ]),
          )),
    );
  }
}
