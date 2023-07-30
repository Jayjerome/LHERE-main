class postModel
{
  String? id;
  String? company_id;
  String? title;
  String? description;
  String? image;
  String? salary;
  String? skill;
  String? city;


  postModel({this.id, this.company_id, this.title, this.description, this.image,
      this.salary, this.skill, this.city});

  factory postModel.fromJson(Map<String, dynamic> json) => postModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      company_id: json["company_id"],
      salary: json["salary"],
      skill: json["skill"],
      city: json["city"],
  );
}