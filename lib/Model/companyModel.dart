class comapnyModel
{
  String? id;
  String? name;
  String? about;
  String? image;
  String? email;
  String? phone;


  comapnyModel({
      this.id, this.name, this.about, this.image, this.email, this.phone});

  factory comapnyModel.fromJson(Map<String, dynamic> json) => comapnyModel(
    id: json["id"],
    name: json["name"],
    about: json["about"],
    image: json["logo"],
    email: json["email"],
    phone: json["phone"],

  );
}