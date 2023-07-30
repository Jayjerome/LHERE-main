class questiondata
{
  String? description;
  String? question_id;
  String? optiona;
  String? optionb;
  String? optionc;
  String? optiond;
  String? answer;


 questiondata({this.description, this.question_id, this.optiona, this.optionb,
      this.optionc, this.optiond, this.answer});

  factory questiondata.fromJson(Map<String, dynamic> json) => questiondata(

  question_id:json["id"],
   description:json["title"] ,
   optiona:json["optiona"],
   optionb:json["optionb"],
   optionc:json["optionc"],
   optiond:json["optiond"],
   answer: json["answer"],



  );


}
