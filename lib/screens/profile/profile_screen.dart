import "package:flutter/material.dart";

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      children: [
        Center(child: Text('Đây là màn hình Profile')),
        Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              controller: birthdayController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101));
                },
              )),
            ),
          ]),
        )
      ],
    ));
  }
}
