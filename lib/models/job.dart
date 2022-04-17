// class Jobs {
//   Jobs(this.createBy, this.description, this.experience, this.industry, this.location, this.salary, this.type, this.workplaceType, this.isClose, {required this.title, required this.genre});

//   Jobs.fromJson(Map<String, Object?> json)
//     : this(
//         title: json['title']! as String,
//         createBy: json['createBy']! as String,
//         description: json['description']! as String,
//         experience: json['experience']! as String,
//         industry: json['industry']! as String,
//         location: json['location']! as String,
//         salary: json['salary']! as String,
//         type: json['type']! as String,
//         workplaceType: json['workplaceType']! as String,
//         isClose: json['isClose']! as String,
//       );


//   final String title;
//   final String createBy;
//   final String description;
//   final String experience;
//   final String industry;
//   final String location;
//   final String salary;
//   final String type;
//   final String workplaceType;
//   final String isClose;

//   Map<String, Object?> toJson() {
//     return {
//       'title': title,
//       'genre': genre,
//     };
//   }
// }