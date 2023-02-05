class Team
{
  String? Name;
  String? level;
  Team({
     this.Name,
     this.level
});

  Team.fromJson(Map<String,dynamic>json)
  {
    Name=json["Name"];
    level=json["level"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Name"]=this.Name;
    data["level"]=this.level;
    return data;
  }
}