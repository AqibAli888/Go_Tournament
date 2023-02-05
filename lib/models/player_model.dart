class Player_model
{
  String? Age;
  String? Player_Name;
  String?Shirt_Number;
  Player_model({
    required this.Age,
    required this.Player_Name,
    required this.Shirt_Number

  });

  Player_model.fromJson(Map<String,dynamic>json)
  {
    Age=json["Age"];
    Player_Name=json["Player_Name"];
    Shirt_Number=json["Shirt_Number"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Shirt_Number"]=this.Shirt_Number;
    data["Player_Name"]=this.Player_Name;
    data["Age"]=this.Age;
    return data;
  }

}