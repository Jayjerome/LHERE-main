class quizdetailModel
{
  String? id;
  String? title;
  String? date;
  String? time;
  String? description;
  String? category;
  String? status;


  quizdetailModel({this.id, this.title, this.date, this.time, this.description,
      this.category, this.status});

  factory quizdetailModel.fromJson(Map<String, dynamic> json) => quizdetailModel(
    id: json["quizid"],
    title: json["title"],
    date: json["date"],
    time: json["time"],
   description: json["description"],
   category: json["qcat"],
    status: json["status"],

  );
}