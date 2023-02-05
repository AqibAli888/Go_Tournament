class Main_Player
{
  String? Name;
  String? shirt_Number;
  String? level;
  Main_Player({
    this.Name,
    this.level,
    this.shirt_Number
  });

  Main_Player.fromJson(Map<String,dynamic>json)
  {
    Name=json["Name"];
    shirt_Number=json["shirt_Number"];
    level=json["level"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Name"]=this.Name;
    data["level"]=this.level;
    data["shirt_Numbe"]=this.shirt_Number;
    return data;
  }
}